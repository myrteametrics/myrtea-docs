# Installation

## Prerequisites

Myrtea needs two external backbone components to run:

- **PostgreSQL v10+** (v16 recommended)
- **Elasticsearch 7.17+ or 8.x**

Quick start with Docker:

```sh
# Single Elasticsearch node
docker run -d --name myrtea-elasticsearch \
  -p 9200:9200 -p 9300:9300 \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch:7.17.28

# PostgreSQL instance
docker run -d --name myrtea-postgres \
  -p 5432:5432 \
  -e POSTGRES_DB="postgres" \
  -e POSTGRES_USER="postgres" \
  -e POSTGRES_PASSWORD="postgres" \
  postgres:16-alpine
```

## Installing the Engine API

### From Source

Requires Go 1.23+ and GNU make.

```sh
git clone https://github.com/myrteametrics/myrtea-engine-api.git
cd myrtea-engine-api
make swag build
```

Run the compiled binary:

```sh
make run
```

Or build a local Docker image:

```sh
make docker-build-local
```

### Database Migrations

By default the Engine API runs migrations on startup (`POSTGRESQL_MIGRATION_ON_STARTUP = "true"`).

To run them manually:

```sh
go install github.com/pressly/goose/v3/cmd/goose@latest
cd migrations
goose postgres "user=postgres dbname=postgres ****** host=localhost sslmode=disable" up
```

### With Docker

```sh
docker pull ghcr.io/myrteametrics/myrtea-engine-api:latest  # adjust tag as needed
docker run -d --name myrtea-engine -p 9000:9000 \
  -v $PWD/config/engine-api.toml:/app/config/engine-api.toml \
  ghcr.io/myrteametrics/myrtea-engine-api:latest
```

Configuration can also be provided via environment variables prefixed with `MYRTEA_`:

```sh
docker run -d --name myrtea-engine -p 9000:9000 \
  -e MYRTEA_HTTP_SERVER_API_ENABLE_SECURITY=false \
  ghcr.io/myrteametrics/myrtea-engine-api:latest
```

### With Docker Compose

Two compose files are provided in the repository: `docker-compose.yml` (production) and `docker-compose.dev.yml` (development).

**Production:**

Create a `.env` file:

```env
POSTGRES_DB=db
POSTGRES_USER=pg-user
POSTGRES_PASSWORD=pg-pass
```

Then:

```sh
docker-compose --env-file .env up
```

**Development:**

```sh
docker-compose -f docker-compose.dev.yml up
```

!!! note
    When running inside Docker containers, replace all `localhost` occurrences in `config/engine-api.toml` with the appropriate container service name.

## Installing the Ingester API

```sh
git clone https://github.com/myrteametrics/myrtea-ingester-api.git
cd myrtea-ingester-api
make build
make run
```

The Ingester API runs on port **9001** by default and exposes a single endpoint: `POST /api/v5/ingester/data`.

## Configuration

- Engine API: `config/engine-api.toml` — see [Engine API configuration reference](../technical/engine/configuration.md)
- Ingester API: `config/ingester-api.toml` — see [Ingester API configuration reference](../technical/ingester/configuration.md)

Both components also accept environment variables prefixed with `MYRTEA_` (e.g. `MYRTEA_ELASTICSEARCH_URLS`).

## Swagger UI

Once running, each API exposes an interactive Swagger UI:

- Engine API: `http://localhost:9000/swagger/index.html`
- Ingester API: `http://localhost:9001/swagger/index.html`
