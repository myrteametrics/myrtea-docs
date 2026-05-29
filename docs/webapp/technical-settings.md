# Technical Settings

The **Technical Settings** domain (`src/app/features/settings-technical`) provides infrastructure and backend configuration. Changes here affect how the Engine API connects to external systems and manages its own services.

## Connector Config

Path: `components/connector-config`

**Connectors** are pluggable backend adapters that integrate external data sources (databases, message brokers, custom APIs). The connector configuration UI allows creating and managing connector instances dynamically without redeploying the backend.

Each connector entry specifies:

- A **name** (unique identifier used in ingester routes)
- A **type** (e.g. `sql`, `kafka`, `custom`)
- A **configuration block** — a JSON object whose structure depends on the connector type

Refer to the [Kafka connector](../technical/connectors/kafka.md) documentation for a type-specific reference.

## Elastic Config

Path: `components/elastic-config`

The **Elastic Config** section manages the Elasticsearch connection profiles used by the Engine API.

Key settings:

| Field | Description |
|-------|-------------|
| URLs | One or more Elasticsearch node URLs |
| Default connection | Marks which profile is used for standard queries |
| Export target | Marks which profile is used for data export operations |
| Index prefix | Optional prefix applied to all managed indices |
| Authentication | Username/password or API key credentials for the cluster |

Multiple profiles can be defined (e.g. one for production data, one for a dedicated export cluster).

## External Config

Path: `components/external-config`

**External configurations** store arbitrary raw JSON objects that custom frontend applications (`src/app/custom/`) or external tooling can read via the Engine API. They act as a remote key-value store with structured values.

Use cases:

- Storing feature flags for a custom UI module
- Providing runtime configuration to an external dashboard
- Sharing shared parameters across multiple custom apps that connect to the same Engine API

Each entry has:

- A **key** (unique name)
- A **value** (any valid JSON object)

## Service Manager

Path: `components/service-manager`

The **Service Manager** provides a simple control panel for backend services registered with the Engine API.

Available operations:

| Action | Description |
|--------|-------------|
| Status | View the current state of a service (running, stopped, error) |
| Restart | Trigger a graceful restart of a service |

This is particularly useful for applying configuration changes that require a service reload without a full platform restart.
