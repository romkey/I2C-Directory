# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/) and this project adheres to
[Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-06-11

### Changed
- Upgraded Ruby 2.7.5 → 4.0.5 and Rails 5.2 → 8.1.
- Updated every dependency to current versions: Puma 8, PostgreSQL 16, Redis 8,
  Sidekiq 8 (with redis-client), Devise 4.9, Nokogiri 1.18+, and more.
- Migrated the asset pipeline from Sprockets to **Propshaft** with
  **cssbundling-rails** (Bootstrap 5.3 compiled via Dart Sass), **importmap-rails**,
  **Turbo**, and **Stimulus**.
- Ported all views from Bootstrap 4 to Bootstrap 5.3.
- Replaced font-awesome-rails with Bootstrap Icons.
- Replaced will_paginate / will_paginate-bootstrap4 with **pagy**.
- Switched linting to **rubocop-rails-omakase** and added a `.rubocop_todo`-free
  clean baseline.
- Rebuilt the Docker setup: multi-stage `Dockerfile` (development + production
  targets, Node 24 via NodeSource), and namespaced compose files for dev, test,
  lint, and production.
- Rewrote the GitHub Actions workflows (CI, lint, docker) for the new toolchain.

### Replaced
- Removed the unmaintained `high_voltage` gem in favor of a small `PagesController`.
- Removed the unmaintained `contact_us` gem in favor of an in-app
  `ContactsController` + `Contact` model + `ContactMailer`.
- Removed `cookieconsent2-rails`; the site only sets a strictly-necessary session
  cookie, so a consent banner is not required.
- Removed jQuery; the datasheet "Use" button is now a Stimulus controller.

### Fixed
- Parameterized the device search query, eliminating a SQL-injection vector.
- Replaced removed Rails APIs (`update_attributes` → `update`,
  `to_s(:rfc822)` → `to_fs(:rfc822)`).
- Fixed the C++ scanner download template rendering under Rails 8.
- Fixed the device JSON partial to no longer reference a nonexistent attribute.
