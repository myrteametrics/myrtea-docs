# Architecture

## High Level Architecture

Myrtea is composed of several components that work together to collect, process, and expose business KPIs.

```
External Data Sources (Kafka, SQL, custom)
        │
        ▼
 ┌──────────────┐        ┌───────────────────────┐
 │ Ingester API │──────▶ │     Elasticsearch      │
 │  (port 9001) │        │  (data store / index)  │
 └──────────────┘        └───────────┬───────────┘
                                     │
                         ┌───────────▼───────────┐
                         │      Engine API        │
                         │  (port 9000, /api/v5)  │
                         │ • Models / Facts        │
                         │ • Situations / Rules    │
                         │ • Scheduler             │
                         │ • Export / Notifier     │
                         └───────────┬───────────┘
                                     │
                         ┌───────────▼───────────┐
                         │      PostgreSQL         │
                         │  (config & history)    │
                         └───────────────────────┘
```

## Internal components

| Component    | Ownership | Technology         | Default exposed port |
|--------------|-----------|--------------------|----------------------|
| Engine-API   | Internal  | Go 1.26+           | 9000                 |
| Ingester-API | Internal  | Go 1.24+           | 9001                 |
| Connectors   | Internal  | Multiple (Go, ...) | N/A                  |

## Internal or Provided components

| Component     | Ownership              | Technology                 | Default exposed port |
|---------------|------------------------|----------------------------|----------------------|
| Elasticsearch | Internal (or provided) | Elasticsearch 7.17+ or 8.x | 9200, 9300           |
| PostgreSQL    | Internal (or provided) | PostgreSQL 10+ (16 rec.)   | 5432                 |

## External components

| Component              | Ownership | Technology | Default exposed port |
|------------------------|-----------|------------|----------------------|
| Customer Kafka Brokers | External  | Kafka      | 9092                 |
| Any SQL database       | External  | Oracle, PG | varies               |

## API versioning

All Engine API and Ingester API endpoints are served under `/api/v5`.

Both APIs expose a Swagger UI at `/swagger/index.html` (configurable via `SWAGGER_HOST` and `SWAGGER_BASEPATH`).

## Plugin system

The Engine API supports an optional plugin system (based on [go-plugin](https://github.com/hashicorp/go-plugin)) that allows extending the platform with custom services. Plugins are loaded at startup from the `plugin/` directory.

## Authentication

Two authentication modes are supported (configured via `AUTHENTICATION_MODE`):

- **BASIC** (default) — JWT tokens issued by the Engine API's `/login` endpoint, signed with `JWT_SIGNING_KEY`.
- **OIDC** — OpenID Connect integration (e.g. Google, Keycloak). See [Security](../security/general.md) for details.
