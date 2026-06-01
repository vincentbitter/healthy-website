#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./release-description.sh <base_ref> <head_ref>
#   ./release-description.sh <head_ref>   (base = first commit)
#
# Example:
#   ./release-description.sh v1.2.0 v1.3.0
#
# Requires:
#   export OPENROUTER_API_KEY="..."

BASE="${1:-}"
HEAD="${2:-}"

if [[ -n "$BASE" && -z "$HEAD" ]]; then
  HEAD="$BASE"
  BASE=$(git rev-list --max-parents=0 HEAD)
fi

fail() {
  jq -n --arg msg "$1" '{ error: $msg }'
  exit 1
}

if [[ -z "$BASE" || -z "$HEAD" ]]; then
  fail "Usage: ./release-description.sh <base_ref> <head_ref> or ./release-description.sh <head_ref>"
fi

COMMITS_FILE=$(mktemp)
DIFF_FILE=$(mktemp)

git log "$BASE".."$HEAD" --pretty=format:"%s" > "$COMMITS_FILE"

git diff "$BASE".."$HEAD" -- . > "$DIFF_FILE"

PAYLOAD=$(jq -n \
  --rawfile commits "$COMMITS_FILE" \
  --rawfile diff "$DIFF_FILE" \
  '{
    model: "nvidia/nemotron-3-super-120b-a12b:free",
    messages: [
      {
        role: "system",
        content: "You are an expert technical writer who creates engaging, high-level release introductions for DevOps engineers. You analyze commit messages and code diffs, identify underlying themes, and merge related changes into coherent storylines. Tone: warm, enthusiastic, confident, informal but professional. Avoid hype; focus on meaningful improvements. Write 1-3 short paragraphs. Group related changes into a single narrative. Mention dependency updates only when they unlock new capabilities or improve stability/performance. Avoid commit-by-commit summaries, file names, commit hashes, or internal development details. Do not mention commits or diffs. Write as if this is the intro of a blog post announcing the release. Goal: make users excited to install the update by clearly explaining what is new and why it matters. Your output must be a valid JSON only: { \"title\": \"<News article title, which includes the version number e.g. v1.x.x>\", \"slug\": \"<Lower case, dashed variant of title. Version can contain dots.\">, \"excerpt\":\"<A SEO Optimized 140-160 character excerpt of the article>\", \"body\": \"<The article content in MD format, without the h1 title because this is already in the meta information>\"}. Make sure therese is not trailing comma after the body property and before the }"
      },
      {
        role: "user",
        content: ("Below are the commit messages:\n\n" + $commits + "\n\nBelow is the code diff:\n\n" + $diff + "\n\nWrite a release introduction according to the system instructions for version $HEAD.")
      }
    ]
  }'
)

RESPONSE=$(printf "%s" "$PAYLOAD" | curl -s -w "\n%{http_code}" https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  --data-binary @-)

HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [[ "$HTTP_STATUS" -ne 200 ]]; then
  fail "OpenRouter API returned HTTP $HTTP_STATUS"
fi

ERROR=$(echo "$BODY" | jq -r '.error // empty')

if [[ -n "$ERROR" ]]; then
  fail "OpenRouter API error: $ERROR"
fi

echo "$BODY" | jq -r '.choices[0].message.content'