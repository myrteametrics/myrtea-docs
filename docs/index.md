# Welcome to Myrtea

**Myrtea** is an open-source platform dedicated to the monitoring of business processes — in real-time or not — with a strong focus on decision assistance.

## What is Myrtea?

Myrtea lets you:

- **Model** your business entities (models, facts, situations)
- **Ingest** data from multiple sources via a dedicated Ingester API or Kafka connectors
- **Calculate** KPIs (facts) and aggregate them into business situations
- **Trigger** alerts and recommendations through a rule engine
- **Monitor** everything through a web interface and a notification system

## Core components

| Component | Technology | Default Port |
|-----------|-----------|-------------|
| [Engine API](https://github.com/myrteametrics/myrtea-engine-api) | Go 1.26+ | 9000 |
| [Ingester API](https://github.com/myrteametrics/myrtea-ingester-api) | Go 1.24+ | 9001 |
| [SDK](https://github.com/myrteametrics/myrtea-sdk) | Go 1.25+ | — |
| Elasticsearch | 7.17+ or 8.x | 9200, 9300 |
| PostgreSQL | 10+ (16 recommended) | 5432 |

## Quick links

- [Architecture overview](architecture/architecture.md)
- [Installation guide](getting-started/installation.md)
- [First application walkthrough](getting-started/first-application.md)
- [Engine API configuration reference](technical/engine/configuration.md)
- [Ingester API configuration reference](technical/ingester/configuration.md)
- [Security & authentication](security/general.md)

## Source repositories

| Repository | Description |
|------------|-------------|
| [myrtea-engine-api](https://github.com/myrteametrics/myrtea-engine-api) | Main REST API — models, facts, situations, rules, scheduler |
| [myrtea-ingester-api](https://github.com/myrteametrics/myrtea-ingester-api) | Data ingestion API — writes to Elasticsearch with merge rules |
| [myrtea-sdk](https://github.com/myrteametrics/myrtea-sdk) | Shared Go library used by all Myrtea services |
| [myrtea-docs](https://github.com/myrteametrics/myrtea-docs) | This documentation |
