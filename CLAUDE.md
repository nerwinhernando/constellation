# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project state

`Constellation` is a freshly generated Rails 8.1 application (Ruby 3.4.1). There is no domain code yet: no models, no migrations, no `db/schema.rb`, no routes beyond the `/up` health check. The `app/` tree contains only the generated `Application*` base classes. Expect to create the first real structure rather than fit into existing conventions.

## Commands

```bash
bin/setup                  # install gems, db:prepare, clear logs, then start the server
bin/setup --skip-server    # same without booting the server
bin/dev                    # start the dev server (thin wrapper over `bin/rails server`)
bin/ci                     # full local CI pipeline (see below)

bin/rails test                                    # all tests except system tests
bin/rails test test/models/foo_test.rb            # single file
bin/rails test test/models/foo_test.rb:42         # single test by line number
bin/rails test:system                             # Capybara + Selenium system tests
bin/rails db:test:prepare test                    # what CI runs

bin/rubocop                # lint (auto-correct with -a)
bin/brakeman               # static security analysis
bin/bundler-audit          # gem CVE audit
bin/importmap audit        # JS dependency audit
bin/jobs                   # run the Solid Queue worker standalone
```

`bin/ci` (defined in `config/ci.rb`, driven by `ActiveSupport::ContinuousIntegration`) runs setup → RuboCop → the three security scans → `bin/rails test` → `db:seed:replant`. System tests are commented out there but **are** run by GitHub Actions, so a change that breaks them passes `bin/ci` and fails on PR. Run `bin/rails test:system` explicitly when touching views or JS.

## Architecture

**Rails 8 "no-PaaS" default stack.** Everything that would normally be a separate service is backed by SQLite:

- `solid_cache` → `Rails.cache`, `solid_queue` → Active Job, `solid_cable` → Action Cable.
- In production these are **four separate SQLite databases** (`primary`, `cache`, `queue`, `cable` in `config/database.yml`), each with its own migrations path (`db/cache_migrate`, `db/queue_migrate`, `db/cable_migrate`) and its own schema file already committed at `db/{cache,queue,cable}_schema.rb`. Application migrations go to the primary database only; don't hand-edit the three Solid schema files.
- Development and test use a single `storage/development.sqlite3` / `storage/test.sqlite3`, and Action Cable uses the `async` adapter in development — cable messages triggered from `bin/rails console` will not reach the browser (use the in-page web console instead).
- In production Solid Queue runs *inside* the Puma process (`SOLID_QUEUE_IN_PUMA: true` in `config/deploy.yml`), not as a separate machine. Recurring jobs are declared in `config/recurring.yml`.

**Frontend is Hotwire + importmap, no build step.** Propshaft asset pipeline, Turbo + Stimulus, JS served as ESM via `config/importmap.rb`; pinned vendored JS lands in `vendor/javascript`. Stimulus controllers in `app/javascript/controllers/` are auto-registered by `controllers/index.js` — adding a file there is enough, no manual registration. CSS is plain `app/assets/stylesheets/`; there is no CSS framework or bundler.

`ApplicationController` sets `allow_browser versions: :modern`, so older browsers get `public/406-unsupported-browser.html`. Anything relying on legacy browser support needs that constraint relaxed first.

**Deployment is Kamal** (`config/deploy.yml`, `Dockerfile`, `bin/kamal`) to a Docker host, with Thruster fronting Puma for asset caching/compression. The registry and server IP in `config/deploy.yml` are still generator placeholders. `storage/` is the persistent volume — the SQLite databases and local Active Storage files live there.

## Style

RuboCop inherits `rubocop-rails-omakase` wholesale; `.rubocop.yml` adds no house rules. Follow Omakase (notably: spaces inside array/hash literal brackets, double-quoted strings are fine, no frozen-string-literal comments).

## handbook/

`handbook/` holds an empty documentation scaffold (`adr/`, `ai/`, `capabilities/`, `engineering/`, `foundation/`, `playbooks/`, `product/`, `prompts/`, `schemas/`). The directories are empty and untracked by git. Architecture decisions and product/engineering notes are intended to go here rather than in the README, which is still the Rails-generated stub.
