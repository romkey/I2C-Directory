# I2C Device Directory

The Internet I2C Device Directory ([i2cdevices.org](https://i2cdevices.org)) — a
searchable catalog of I2C/TwoWire devices and their bus addresses.

## Stack

- **Ruby** 4.0.5, **Rails** 8.1
- **PostgreSQL** 16, **Redis** 8
- **Sidekiq** 8 for background jobs (datasheet/driver suggestion scanners, mail)
- **Propshaft** asset pipeline with **cssbundling-rails** (Bootstrap 5.3 via Sass),
  **importmap-rails**, **Turbo** and **Stimulus**
- **Devise** for authentication, **pagy** for pagination
- Bootstrap Icons for iconography

## Local development

Everything runs in Docker. The compose files namespace their containers,
networks, and volumes so multiple stacks can coexist.

```bash
# Start the dev stack (Postgres, Redis, web, css watcher, Sidekiq)
docker compose -f docker-compose.dev.yml up

# App is served at http://localhost:3000
```

The `web` service builds CSS, runs `db:prepare`, and starts Puma. The `css`
service watches `app/assets/stylesheets` and rebuilds Bootstrap on change.

Copy `.env.example` to `.env` to provide optional configuration (mail, Google
Custom Search API keys for the suggestion jobs, etc.).

### Tests

```bash
docker compose -f docker-compose.test.yml run --rm test
```

### Linting (RuboCop, omakase style)

```bash
# Build the lint image once
docker compose -f docker-compose.lint.build.yml build

# Run RuboCop
docker compose -f docker-compose.lint.yml run --rm rubocop
```

You can also run RuboCop, Brakeman, and the tests with the bundled binstubs
(`bin/rubocop`, `bin/brakeman`, `bin/rails test`) inside any Ruby 4.0 environment.

## Production image

A multi-stage `Dockerfile` builds a slim, non-root production image with assets
precompiled:

```bash
docker build --target production -t i2c-directory:latest \
  --build-arg APP_VERSION="$(cat VERSION)" .
```

`docker-compose.production.yml` runs `web`, `sidekiq`, and `redis`, expecting an
external PostgreSQL via `DATABASE_URL`. Required environment variables:

- `DATABASE_URL` — PostgreSQL connection URL
- `SECRET_KEY_BASE` — Rails secret
- `REDIS_URL` — Redis connection (defaults to the bundled `redis` service)

## Continuous integration

GitHub Actions provides three workflows:

- `ci.yml` — Brakeman, bundler-audit, and the test suite (Postgres 16 + Redis 8)
- `lint.yml` — RuboCop
- `docker.yml` — builds and pushes the production image to GHCR, tagging
  `latest` on `main`, `staging` on `staging`, and semver tags on `v*` tags

## Deployment & versioning

See `.cursor/rules/deployment-rules.mdc`. In short: feature/fix branches target
`staging`; production is promoted via a `staging` → `main` PR. The canonical
version lives in `VERSION` and is exposed to the app as `APP_VERSION`.
