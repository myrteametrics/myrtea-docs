# Engine API — Configuration Reference

The Engine API is configured via `config/engine-api.toml` (TOML format).  
Every key can be overridden by an environment variable with the prefix `MYRTEA_`  
(e.g. `MYRTEA_ELASTICSEARCH_URLS`).

Source: [`config/engine-api.toml`](https://github.com/myrteametrics/myrtea-engine-api/blob/main/config/engine-api.toml)

---

## General

| Key | Default | Description |
|-----|---------|-------------|
| `DEBUG_MODE` | `"false"` | Print **all** config variables on startup (including secrets). Never enable in production. |
| `LOGGER_PRODUCTION` | `"true"` | Enable production-style structured JSON logging. |
| `INSTANCE_NAME` | `"myrtea"` | Instance identifier. Must be identical across all stack components. |

---

## HTTP server

| Key | Default | Description |
|-----|---------|-------------|
| `HTTP_SERVER_PORT` | `"9000"` | Listening port for the API and Swagger UI. |
| `HTTP_SERVER_ENABLE_TLS` | `"false"` | Enable TLS (HTTPS). Requires `HTTP_SERVER_TLS_FILE_CRT` and `HTTP_SERVER_TLS_FILE_KEY`. |
| `HTTP_SERVER_TLS_FILE_CRT` | `"certs/server.rsa.crt"` | Path to the TLS certificate file. |
| `HTTP_SERVER_TLS_FILE_KEY` | `"certs/server.rsa.key"` | Path to the TLS private key file. |
| `HTTP_SERVER_API_ENABLE_CORS` | `"false"` | Enable CORS headers. |
| `HTTP_SERVER_API_ENABLE_SECURITY` | `"true"` | Require a valid JWT on all endpoints. Set to `"false"` for development only. |
| `HTTP_SERVER_API_ENABLE_GATEWAY_MODE` | `"false"` | Trust pre-validated JWTs from an upstream API gateway (skip signature verification). |
| `HTTP_SERVER_API_ENABLE_VERBOSE_ERROR` | `"false"` | Return additional error details in API responses. Do **not** enable in production. |

---

## Swagger UI

| Key | Default | Description |
|-----|---------|-------------|
| `SWAGGER_HOST` | `"localhost:9000"` | Hostname used to call endpoints from the Swagger UI. |
| `SWAGGER_BASEPATH` | `"/api/v5"` | Base path used in the Swagger UI. |
| `SWAGGER_TOPBAR_TITLE` | `""` | Optional title shown in the Swagger topbar. |
| `SWAGGER_TOPBAR_COLOR` | `""` | Optional hex color for the Swagger topbar (e.g. `"#618EF2"`). |

---

## Elasticsearch

| Key | Default | Description |
|-----|---------|-------------|
| `ELASTICSEARCH_URLS` | `["http://localhost:9200"]` | List of Elasticsearch node URLs. |
| `ELASTICSEARCH_AUTH` | `"false"` | Enable Elasticsearch authentication. |
| `ELASTICSEARCH_USERNAME` | `""` | Elasticsearch username (if `ELASTICSEARCH_AUTH = "true"`). |
| `ELASTICSEARCH_PASSWORD` | `""` | Elasticsearch password (if `ELASTICSEARCH_AUTH = "true"`). |
| `ELASTICSEARCH_INSECURE` | `"false"` | Skip TLS certificate verification. Dev/test only. |

---

## PostgreSQL

| Key | Default | Description |
|-----|---------|-------------|
| `POSTGRESQL_HOSTNAME` | `"localhost"` | PostgreSQL host. |
| `POSTGRESQL_PORT` | `"5432"` | PostgreSQL port. |
| `POSTGRESQL_DBNAME` | `"postgres"` | Database name. |
| `POSTGRESQL_USERNAME` | `"postgres"` | Database user. |
| `POSTGRESQL_PASSWORD` | `"postgres"` | Database password. |
| `POSTGRESQL_CONN_POOL_MAX_OPEN` | `"10"` | Maximum open connections in the pool. |
| `POSTGRESQL_CONN_POOL_MAX_IDLE` | `"10"` | Maximum idle connections in the pool. |
| `POSTGRESQL_CONN_MAX_LIFETIME` | `"0"` | Maximum connection lifetime (Go duration string, `"0"` = unlimited). |
| `POSTGRESQL_MIGRATION_ON_STARTUP` | `"true"` | Automatically run database migrations on startup. |

---

## Authentication

| Key | Default | Description |
|-----|---------|-------------|
| `AUTHENTICATION_MODE` | `"BASIC"` | `"BASIC"` or `"OIDC"`. |
| `JWT_SIGNING_KEY` | `""` | JWT signing secret (BASIC mode). Auto-generated when empty in production. |
| `AUTHENTICATION_CREATE_SUPERUSER` | `"false"` | Create an `admin`/`myrtea` account on first run. |
| `AUTHENTICATION_OIDC_CLIENT_ID` | `""` | OIDC client ID. |
| `AUTHENTICATION_OIDC_CLIENT_SECRET` | `""` | OIDC client secret. |
| `AUTHENTICATION_OIDC_REDIRECT_URL` | `"http://127.0.0.1:9000/api/v5/auth/oidc/callback"` | OIDC redirect URI. |
| `AUTHENTICATION_OIDC_ISSUER_URL` | `"https://accounts.google.com"` | OIDC issuer URL. |
| `AUTHENTICATION_OIDC_SCOPES` | `"profile,email,roles"` | Comma-separated OIDC scopes. |
| `AUTHENTICATION_OIDC_FRONT_END_URL` | `"http://127.0.0.1:4200"` | Frontend URL for the post-auth redirect. |
| `AUTHENTICATION_OIDC_ENCRYPTION_KEY` | `"thisis24characterslongs."` | AES key (16/24/32 chars) for state param encryption. Change in production. |

---

## Notifications

| Key | Default | Description |
|-----|---------|-------------|
| `NOTIFICATION_LIFETIME` | `"168h"` | How long notifications are kept in the database (default: 7 days). |

Notification delivery supports both WebSocket (`/api/v5/notifications/ws`) and SSE (`/api/v5/notifications/sse`).

---

## Export

| Key | Default | Description |
|-----|---------|-------------|
| `EXPORT_BASE_PATH` | `"exports/"` | Directory where exported files are stored. |
| `EXPORT_WORKERS_COUNT` | `4` | Number of concurrent export workers. |
| `EXPORT_DISK_RETENTION_DAYS` | `4` | Days before exported files are auto-deleted. |
| `EXPORT_QUEUE_MAX_SIZE` | `30` | Maximum queued export requests. Requests over the limit are rejected. |
| `EXPORT_DIRECT_DOWNLOAD` | `true` | Stream exports directly through the API (`true`) or serve via an external URL (`false`). |
| `EXPORT_INDIRECT_DOWNLOAD_URL` | `""` | Base URL when `EXPORT_DIRECT_DOWNLOAD = false` (e.g. nginx path). |
| `EXPORT_MAX_CUSTOM_SEARCH_REQUESTS` | `10` | Maximum search requests per custom export. |

---

## API keys

| Key | Default | Description |
|-----|---------|-------------|
| `API_KEY_CACHE_DURATION` | `"1h"` | How long API keys are cached in memory before re-validation. |

---

## Scheduler

| Key | Default | Description |
|-----|---------|-------------|
| `ENABLE_CRONS_ON_START` | `"true"` | Start all enabled cron jobs automatically at startup. |
| `JOB_BOOST_LIFETIME` | `"5m"` | TTL for boost/revert actions in the JobBoostManager. |

---

## Aggregate Ingester

| Key | Default | Description |
|-----|---------|-------------|
| `AGGREGATEINGESTER_QUEUE_BUFFER_SIZE` | `"100"` | Queue size for the aggregate ingester. |

---

## SMTP (email notifications)

| Key | Default | Description |
|-----|---------|-------------|
| `SMTP_HOST` | `"smtp.example.com"` | SMTP server hostname. |
| `SMTP_PORT` | `"465"` | SMTP server port. |
| `SMTP_USERNAME` | `"smtp@example.com"` | SMTP authentication username. |
| `SMTP_PASSWORD` | `""` | SMTP authentication password. |

---

## Configuration history

| Key | Default | Description |
|-----|---------|-------------|
| `MAX_CONFIG_HISTORY_RECORDS` | `100` | Maximum configuration history records kept per type. |
| `MAX_EXTERNAL_CONFIG_VERSIONS_TO_KEEP` | `5` | Maximum historical versions kept per external config item. |
