# Ingester API — Configuration Reference

The Ingester API is configured via `config/ingester-api.toml` (TOML format).  
Every key can be overridden by an environment variable with the prefix `MYRTEA_`  
(e.g. `MYRTEA_ELASTICSEARCH_URLS`).

Source: [`config/ingester-api.toml`](https://github.com/myrteametrics/myrtea-ingester-api/blob/main/config/ingester-api.toml)

---

## General

| Key | Default | Description |
|-----|---------|-------------|
| `DEBUG_MODE` | `"false"` | Print **all** config variables on startup. Never enable in production. |
| `LOGGER_PRODUCTION` | `"true"` | Enable production-style structured JSON logging. |
| `INSTANCE_NAME` | `"myrtea"` | Instance identifier. Must match across all stack components. |

---

## HTTP server

| Key | Default | Description |
|-----|---------|-------------|
| `HTTP_SERVER_PORT` | `"9001"` | Listening port for the Ingester API. |
| `HTTP_SERVER_ENABLE_TLS` | `"false"` | Enable TLS (HTTPS). |
| `HTTP_SERVER_TLS_FILE_CRT` | `"certs/server.rsa.crt"` | Path to the TLS certificate. |
| `HTTP_SERVER_TLS_FILE_KEY` | `"certs/server.rsa.key"` | Path to the TLS private key. |
| `HTTP_SERVER_API_ENABLE_CORS` | `"false"` | Enable CORS headers. |
| `HTTP_SERVER_API_ENABLE_SECURITY` | `"false"` | Require JWT auth. Usually disabled for internal service use. |
| `HTTP_SERVER_API_ENABLE_GATEWAY_MODE` | `"false"` | Trust pre-validated JWTs from an upstream API gateway. |
| `HTTP_SERVER_API_ENABLE_VERBOSE_ERROR` | `"false"` | Return additional error details. Do **not** enable in production. |

---

## Swagger UI

| Key | Default | Description |
|-----|---------|-------------|
| `SWAGGER_HOST` | `"localhost:9001"` | Hostname for the Swagger UI. |
| `SWAGGER_BASEPATH` | `"/api/v5"` | Base path for the Swagger UI. |

---

## Elasticsearch

| Key | Default | Description |
|-----|---------|-------------|
| `ELASTICSEARCH_URLS` | `["http://localhost:9200"]` | List of Elasticsearch node URLs. |
| `ELASTICSEARCH_AUTH` | `"false"` | Enable Elasticsearch authentication. |
| `ELASTICSEARCH_USERNAME` | `""` | Elasticsearch username (if auth enabled). |
| `ELASTICSEARCH_PASSWORD` | `""` | Elasticsearch password (if auth enabled). |
| `ELASTICSEARCH_INSECURE` | `"false"` | Skip TLS certificate verification. Dev/test only. |
| `ELASTICSEARCH_HTTP_TIMEOUT` | `"1m"` | HTTP timeout for Elasticsearch requests. |
| `ELASTICSEARCH_DIRECT_MULTI_GET_MODE` | `"false"` | Send `mget` pre-update requests directly to a specific index. |
| `ELASTICSEARCH_MGET_BATCH_SIZE` | `"500"` | Maximum number of documents per `mget` request. |

---

## Ingester tuning

| Key | Default | Description |
|-----|---------|-------------|
| `INGESTER_MAXIMUM_WORKERS` | `"2"` | Number of concurrent workers per document type. |
| `TYPEDINGESTER_QUEUE_BUFFER_SIZE` | `"500"` | Channel buffer size for each `TypedIngester`. |
| `WORKER_QUEUE_BUFFER_SIZE` | `"500"` | Channel buffer size for each worker. |
| `WORKER_MAXIMUM_BUFFER_SIZE` | `"2000"` | Maximum documents buffered before a bulk flush to Elasticsearch. |
| `WORKER_FORCE_FLUSH_TIMEOUT_SEC` | `"10"` | Seconds before a forced flush regardless of buffer size. |

---

## Debug

| Key | Default | Description |
|-----|---------|-------------|
| `DEBUG_DRY_RUN_ELASTICSEARCH` | `"false"` | Skip all Elasticsearch interactions (no enrichment, no document write). |
