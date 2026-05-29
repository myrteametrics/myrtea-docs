# Documentation Changelog

This file records changes made to the documentation as part of the **2025 docs audit**,
performed against the current state of the `myrteametrics` repositories.

---

## 2025 Docs Audit

### What was audited

The following source repositories were used as sources of truth:

| Repository | Version audited |
|------------|----------------|
| [`myrtea-engine-api`](https://github.com/myrteametrics/myrtea-engine-api) | v5 (Go 1.26) |
| [`myrtea-ingester-api`](https://github.com/myrteametrics/myrtea-ingester-api) | v5 (Go 1.24) |
| [`myrtea-sdk`](https://github.com/myrteametrics/myrtea-sdk) | v5 (Go 1.25) |

---

### Changes made

#### `docs/index.md` — Homepage rewrite

- **Was:** Default MkDocs boilerplate ("Welcome to MkDocs").
- **Now:** Real Myrtea homepage with a component overview table, quick-start links, and a
  repository reference table.

---

#### `docs/architecture/architecture.md` — Architecture update

- **Removed:**
  - *Explainer-API* (Python 3.6 service) — this component no longer exists in the public org.
  - Angular 8 Web Interface reference.
  - Go 1.14 / Elasticsearch 6.x version pins.
- **Added:**
  - ASCII architecture diagram.
  - Correct component versions (Go 1.24–1.26, Elasticsearch 7.17+ / 8.x).
  - Plugin system section (Engine API uses `hashicorp/go-plugin`).
  - Authentication modes section (BASIC and OIDC).

---

#### `docs/getting-started/installation.md` — New content (was empty)

- **Was:** Empty file (1 byte).
- **Now:** Full installation guide covering:
  - Prerequisites (Go 1.24+, Docker, Elasticsearch 7.17+/8.x, PostgreSQL 14+).
  - Docker Compose quickstart.
  - Building from source (Engine API and Ingester API).
  - Swagger UI access at `/swagger/index.html`.

---

#### `docs/getting-started/first-application.md` — New content (was empty)

- **Was:** Empty file (1 byte).
- **Now:** Six-step guided walkthrough:
  1. Start the stack.
  2. Authenticate and obtain a JWT.
  3. Create a Fact definition.
  4. Create a Situation.
  5. Trigger a calculation.
  6. Query results.
  - All steps include working `curl` examples.

---

#### `docs/security/general.md` — Security docs update

- **Was:** Only documented HTTP BASIC auth.
- **Added:**
  - OIDC authentication section (all config env vars).
  - Gateway mode (upstream JWT trust, no signature re-validation).
  - API keys section (`X-API-Key` header, admin management endpoint).
  - RBAC overview (roles granted through user groups).

---

#### `docs/technical/ingester/ingester.md` — Ingester API update

- **Fixed:** API route was documented as `/ingester/data`; corrected to `POST /api/v5/ingester/data`.
- **Fixed:** Version references changed from v4 to v5 throughout.
- **Fixed:** Merge mode constants clarified (`Self=1`, `EnrichTo=2`, `EnrichFrom=3`).
- **Added:** `curl` example for sending documents to the ingester.
- **Added:** Link to the new configuration reference page.

---

#### `docs/technical/ingester/configuration.md` — NEW

New configuration reference for the Ingester API, derived directly from
`config/ingester-api.toml`. Covers:

- HTTP server settings (port, TLS, CORS, security, gateway mode).
- Elasticsearch connection and tuning options.
- Worker concurrency and buffer-size parameters.
- Dry-run / debug mode.

---

#### `docs/technical/engine/configuration.md` — NEW

New configuration reference for the Engine API, derived directly from
`config/engine-api.toml`. Covers:

- HTTP server settings (port, TLS, CORS, security, gateway mode, verbose errors).
- Swagger UI customisation.
- Elasticsearch connection settings.
- PostgreSQL connection pool and auto-migration control.
- Authentication (BASIC JWT and OIDC with all env vars).
- Notifications lifetime and delivery (WebSocket + SSE endpoints).
- Export system (workers, retention, queue size, direct vs. indirect download).
- API key cache duration.
- Scheduler and job boost settings.
- SMTP configuration.
- Configuration history retention limits.

---

#### `docs/technical/postgres/postgres.md` — PostgreSQL tables update

- **Added** the following tables that were missing from the list:
  - `api_keys` — API key credentials.
  - `config_history_v1` — Audit log of configuration changes.
  - `external_config_folders_v1` — Folder hierarchy for external configs.
  - `external_generic_config_v1` — Untyped JSON external configuration.
  - `external_generic_config_versions_v1` — Versioned external config history.
  - `functional_situation_v1` — Functional situation definitions.
  - `functional_situation_instances_v1` — Links to template instances.
  - `functional_situation_situations_v1` — Links to standalone situations.
  - `mail_templates_v1` — Email notification templates.
  - `tags_v1` — Tag definitions.
  - `variables_config_v1` — Dynamic key-value variable store.
- **Fixed:** `fact_history_v1` replaced by `fact_history_v5` (migration 00500+).
- **Added:** Short descriptions for all tables.
- **Updated:** `pg_dump` backup commands to include all new tables.

---

### Sections validated against source repositories

- [x] Component versions (Go, ES, PG)
- [x] Authentication modes (BASIC, OIDC)
- [x] API base path (`/api/v5`)
- [x] Ingester route (`POST /api/v5/ingester/data`)
- [x] Ingester merge modes (constants from `ingester-api` source)
- [x] Database migrations (goose-based, auto-run on startup)
- [x] PostgreSQL table list (cross-referenced with migration files 00401–00537)
- [x] Engine API configuration (cross-referenced with `config/engine-api.toml`)
- [x] Ingester API configuration (cross-referenced with `config/ingester-api.toml`)

---

### Areas flagged for human confirmation

The following items could not be fully verified from publicly available sources and
may require review by a Myrtea maintainer:

1. **Frontend repository** — `myrtea-webapp-settings` was referenced in the audit scope
   but does not appear in the public `myrteametrics` GitHub org. Frontend-specific
   documentation could not be audited or updated.

2. **Explainer-API removal** — The old architecture docs referenced a Python 3.6
   Explainer-API service. This component no longer exists in any public repo. The
   architecture doc now omits it. Please confirm this is intentional and the service
   has been fully deprecated.

3. **`connectors_config_v1` / `connectors_executions_log_v1`** — The old docs listed
   these as `No(*)` (non-packaged). Based on their nature (configuration data), they
   are now listed as `Yes` (packaged). Please verify this is correct.

4. **RBAC / roles model** — The security section documents roles at a high level.
   The detailed roles/permissions model was not fully explored. A dedicated RBAC
   reference page may be valuable.

5. **Export API endpoints** — The export system was identified in config/source code
   but the endpoint details were not fully documented. A dedicated export reference
   page would be useful.

6. **Services management** — Engine API exposes service management endpoints but
   these are not yet documented.

7. **Notifications API** — WebSocket and SSE endpoints are referenced in the
   configuration doc but a full notification integration guide is missing.
