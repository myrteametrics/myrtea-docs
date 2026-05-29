# Business Settings

The **Business Settings** domain (`src/app/features/settings-business`) is the core of the webapp. It contains all the supervision logic and maps directly to the Engine API resources.

## Model

Path: `components/model`

A **model** defines the data schema for a business entity. Every fact must be attached to a model.

A model contains:

- **Field definitions** — the tree of fields and their types (`string`, `integer`, `float`, `datetime`, `object`)
- **Elasticsearch options** — index rotation policy (cron expression), purge settings, alias patch depth, and any advanced index-level options (shards, replicas, …)

Models map 1-to-1 to Elasticsearch index aliases. Each rotation creates a new concrete index while the alias stays stable.

See [Model settings reference](../settings/model/model.md) for the full field-type reference.

## Fact

Path: `components/fact`

A **fact** declaratively describes how to build an indicator (KPI) from a model. It is translated at runtime into an Elasticsearch query — no intermediate computation layer.

A fact defines:

- An **intent** — the aggregation operator (`Count`, `Average`, `Sum`, `Min`, `Max`) and the target term (a model field or a script)
- Optional **dimensions** — breakdown axes (by value, histogram, date histogram)
- Optional **conditions** — filter tree applied before the aggregation
- Optional **parameters** — when the fact is flagged as a template, parameters act as placeholders substituted at evaluation time by the parent situation

Facts are reusable: the same fact can be attached to multiple situations.

See [Fact settings reference](../settings/fact/fact.md) and [Supported functions](../settings/fact/supported-functions.md) for full details.

## Situation

Path: `components/situation`

A **situation** groups facts, business rules, and calendars under a shared evaluation context. It is the primary business segmentation unit.

Key concepts:

- **Facts** — attached facts inherit the situation parameters
- **Rules** — attached rules are evaluated after all facts are computed
- **Parameters** — key-value pairs that are passed down to facts and rules
- **Template situations** — a single template generates multiple *situation instances*, each with its own parameter overrides

Two situation types exist:

| Type | Description |
|------|-------------|
| Standard | Static — no instances |
| Template | Generates multiple instances from a shared configuration |

See [Situation settings reference](../settings/situation/situation.md) for full details.

## Business Rule

Path: `components/business-rule`

A **business rule** is the final step of the supervision chain. It is evaluated after all facts in a situation have been computed.

A rule contains:

- **Conditions** — evaluated against fact values, situation parameters, and global variables. Conditions can be individually enabled or disabled.
- **Actions** — executed when conditions are met (e.g. send an email, set a critical indicator, trigger a webhook)
- **Stop-on-failure** — by default, execution stops if a condition evaluation fails; this behaviour is configurable

Parameter inheritance priority (highest to lowest):

1. Situation instance parameters
2. Situation global parameters
3. Business rule default parameters

See [Business rule settings reference](../settings/business-rule/business-rule.md) for full details.

## Scheduler

Path: `components/scheduler`

The **scheduler** defines cron-based periodic tasks. Each task triggers evaluation of a set of facts, which in turn drives the full supervision workflow.

Configuration:

- A **cron expression** that controls the evaluation frequency
- The list of **situations** to evaluate on each trigger

See [Scheduler settings reference](../settings/scheduler/scheduler.md) for full details.

## Calendar

Path: `components/calendar`

A **calendar** defines time ranges during which supervision is active. Attaching a calendar to a situation restricts rule evaluation to the specified time windows.

Typical use case: evaluate rules only on business days (Monday–Friday), excluding weekends and public holidays.

A calendar is composed of one or more **time periods**, each defined by:

- A start date/time
- An end date/time
- An optional recurrence rule

## Functional Situation

Path: `components/functional-situation`

A **functional situation** is a logical grouping of technical situations. It does not affect the evaluation engine — it is a pure UI concept that improves readability and navigation when the number of situations is large.

Use it to group related situations under a meaningful business label (e.g. "Order management", "Fleet monitoring").

## Tag

Path: `components/tag`

A **tag** can be attached to situations and situation instances to improve navigation and filtering in the UI.

Each tag has:

- A **name**
- A **color** (for visual identification)

Tags are especially useful in large deployments with many situations.

## Template

Path: `components/template`

**Templates** are email content templates used by business rule actions of type "send email". They decouple the email body design from the rule configuration.

A template is composed of a **subject** and a **body**, both supporting variable interpolation using the standard Myrtea token syntax.

## Variables Config

Path: `components/variables-config`

**Global variables** are platform-wide key-value pairs available in fact conditions and business rule expressions. They avoid duplication when the same threshold or configuration value is used across multiple facts or rules.

| Field | Description |
|-------|-------------|
| Key | Unique variable name |
| Value | Any scalar value (string, number, boolean) |

Changes to a global variable take effect immediately on the next evaluation cycle — no rule or fact needs to be republished.
