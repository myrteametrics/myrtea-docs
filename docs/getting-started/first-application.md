# First Application

This guide walks you through building your first Myrtea monitoring application. By the end you will have:

1. A **model** describing a business entity.
2. A **fact** (KPI) computed from that model.
3. A **situation** grouping one or more facts.
4. A **business rule** that generates an alert when a threshold is exceeded.
5. A **scheduler job** that recalculates the situation on a schedule.

## Assumptions

- The Engine API is running at `http://localhost:9000` (security disabled for simplicity: `HTTP_SERVER_API_ENABLE_SECURITY = "false"`).
- The Ingester API is running at `http://localhost:9001`.
- Elasticsearch and PostgreSQL are available.

---

## Step 1 — Create a Model

A **model** describes the structure of the data stored in Elasticsearch.

See [Model creation](model-creation.md) for the full reference.

```sh
curl -s -X POST http://localhost:9000/api/v5/models \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "order",
    "fields": [
      {"name": "id",        "type": "string"},
      {"name": "status",    "type": "keyword"},
      {"name": "amount",    "type": "float"},
      {"name": "createdAt", "type": "datetime"}
    ]
  }'
```

Note the `id` returned — you will need it in the next steps.

---

## Step 2 — Ingest Some Data

Use the Ingester API to push sample documents:

```sh
curl -s -X POST http://localhost:9001/api/v5/ingester/data \
  -H 'Content-Type: application/json' \
  -d '{
    "uuid": "batch-001",
    "documentType": "order",
    "merge": [{"mode": 1, "type": "order"}],
    "docs": [
      {"id": "ord-1", "index": "order", "source": {"id": "ord-1", "status": "pending",   "amount": 150.0, "createdAt": "2024-01-15T10:00:00Z"}},
      {"id": "ord-2", "index": "order", "source": {"id": "ord-2", "status": "completed", "amount": 320.0, "createdAt": "2024-01-15T11:00:00Z"}},
      {"id": "ord-3", "index": "order", "source": {"id": "ord-3", "status": "pending",   "amount": 75.0,  "createdAt": "2024-01-15T12:00:00Z"}}
    ]
  }'
```

---

## Step 3 — Create a Fact

A **fact** is a KPI computed on the model. Let's count pending orders.

See [Facts creation](facts-creation.md) for the full reference.

```sh
curl -s -X POST http://localhost:9000/api/v5/facts \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "count_pending_orders",
    "model": {"id": 1},
    "intent": {
      "operator": "count",
      "term": "order"
    },
    "condition": {
      "operator": "For",
      "field": "status",
      "value": "pending"
    }
  }'
```

---

## Step 4 — Create a Situation

A **situation** groups facts into a business context.

See [Situation creation](situation-creation.md) for the full reference.

```sh
curl -s -X POST http://localhost:9000/api/v5/situations \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "order_monitoring",
    "facts": [{"id": 1}]
  }'
```

---

## Step 5 — Create a Business Rule

A **business rule** fires when a situation matches a condition.

See [Business rules creation](business-rules-creation.md) for the full reference.

```sh
curl -s -X POST http://localhost:9000/api/v5/rules \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "too_many_pending_orders",
    "cases": [
      {
        "name": "alert_high_pending",
        "condition": "count_pending_orders > 10",
        "actions": [
          {"name": "create_issue"}
        ]
      }
    ]
  }'
```

---

## Step 6 — Create a Scheduler Job

A **scheduler job** triggers situation evaluation on a cron schedule.

See [Scheduler settings](../settings/scheduler/scheduler.md) for the full reference.

```sh
curl -s -X POST http://localhost:9000/api/v5/scheduler/jobs \
  -H 'Content-Type: application/json' \
  -d '{
    "name":     "evaluate_order_monitoring",
    "cronexpr": "*/5 * * * *",
    "jobtype":  1,
    "situationId": 1
  }'
```

---

## What's next?

- Explore [Fact settings](../settings/fact/fact.md) to build more complex KPIs.
- Learn about [Situation templates](../settings/situation/situation.md) for multi-tenant scenarios.
- Configure [Security & authentication](../security/general.md) before going to production.
