---
layout: post
title: "Healthy v1.0.1: Streamlined Dev Workflow with Code Standards and TypeScript"
date: 2026-06-19
excerpt: "Discover how Healthy v1.0.1 brings PHP_CodeSniffer integration, TypeScript admin scripts, updated tooling, and devcontainer tweaks for a smoother, more reliable development experience."
---

This release focuses on making everyday development safer and faster. We’ve added PHP_CodeSniffer with WordPress coding standards to the CI pipeline and configured it locally in VS Code, so style issues are caught early and fixed automatically on save. The admin interface has migrated from plain JavaScript to TypeScript, improving maintainability and leveraging the latest esbuild and Playwright updates for faster builds and more reliable end-to-end tests.

Under the hood, we’ve refreshed the development container: Node.js is now locked to v24.17.0, Xdebug logging is disabled for CLI runs, and the devcontainer features have been bumped to the latest stable versions. Dependency updates across semantic-release, esbuild, @types/node, and phpunit ensure that our release workflow stays secure and performant.

Finally, two important bugs were squashed—the health check test now works correctly on the admin dashboard, and the version‑number replacement logic no longer produces invalid syntax. Together, these changes give you a more robust foundation for building, testing, and releasing Healthy with confidence.

## Changes since v1.0.0

{% include changelogs/v1.0.1.md %}