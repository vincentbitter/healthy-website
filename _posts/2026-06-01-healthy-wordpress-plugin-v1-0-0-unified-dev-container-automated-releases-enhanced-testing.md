---
layout: post
title: "Healthy WordPress Plugin v1.0.0: Unified Dev Container, Automated Releases & Enhanced Testing"
date: 2026-06-01
excerpt: "Discover Healthy v1.0.0 with unified DevContainer setup, semantic-release automation, comprehensive testing infrastructure, and WordPress plugin enhancements for better health monitoring."
---

The Healthy WordPress plugin has reached a major milestone with version 1.0.0, bringing significant improvements to both the development experience and the plugin's functionality. This release represents a complete overhaul of how developers work with the plugin, featuring a unified DevContainer setup that provides a consistent, ready-to-code environment with all necessary tools pre-configured.

Key improvements include a robust testing infrastructure with both unit tests (PHPUnit) and end-to-end tests (Playwright), automated release pipelines using semantic-release, and enhanced WordPress integration with a new settings page to test the health check endpoint and a live endpoint for monitoring. The DevContainer now uses Microsoft's official PHP development container image, includes Composer by default, and has been optimized for GitHub Codespaces with proper handling of forwarded headers and file permissions.

Under the hood, we've modernized our toolchain with Node.js v26, esbuild v0.28, and PHPUnit v13, while adding Renovate for automated dependency updates. These changes aren't just about keeping up-to-date - they unlock faster builds, better test reliability, and a smoother path from development to production. Whether you're contributing to Healthy or using it in your WordPress environment, this release makes everything more reliable, transparent, and enjoyable to work with.

## New in this version

{% include changelogs/v1.0.0.md %}
