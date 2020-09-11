# PostgreSQL tables

## Schema

[Schema PNG]

## List of tables

| Table                             | Packaged ? | Description         |
| --------------------------------- | ---------- | ------------------- |
| `calendar_union_v1`               | Yes        | Missing description |
| `calendar_v1`                     | Yes        | Missing description |
| `connectors_config_v1`            | No(*)      | Missing description |
| `connectors_executions_log_v1`    | No(*)      | Missing description |
| `elasticsearch_indices_v1`        | No(*)      | Missing description |
| `fact_baseline_definition_v1`     | Yes        | Missing description |
| `fact_baseline_v1`                | Yes        | Missing description |
| `fact_definition_v1`              | Yes        | Missing description |
| `fact_history_v1`                 | No(*)      | Missing description |
| `interaction_history_v1`          | No(*)      | Missing description |
| `issue_detection_feedback_v3`     | No(*)      | Missing description |
| `issue_resolution_draft_v1`       | No(*)      | Missing description |
| `issue_resolution_v1`             | No(*)      | Missing description |
| `issues_v1`                       | No(*)      | Missing description |
| `job_schedules_v1`                | Yes        | Missing description |
| `model_v1`                        | Yes        | Missing description |
| `notifications_history_v1`        | No(*)      | Missing description |
| `ref_action_v1`                   | Yes        | Missing description |
| `ref_rootcause_v1`                | Yes        | Missing description |
| `rule_versions_v1`                | Yes        | Missing description |
| `rules_v1`                        | Yes        | Missing description |
| `situation_definition_v1`         | Yes        | Missing description |
| `situation_facts_v1`              | Yes        | Missing description |
| `situation_history_v1`            | No(*)      | Missing description |
| `situation_rules_v1`              | Yes        | Missing description |
| `situation_template_instances_v1` | Yes        | Missing description |
| `user_groups_v1`                  | Yes        | Missing description |
| `user_memberships_v1`             | Yes        | Missing description |
| `users_v1`                        | Yes        | Missing description |

*(\*) Table related to issue, usage or calculation history, and feedback are not packaged to avoid side effect during and after deployment in another environment.*

## Application packaging

### Custom format (binary, non human-readable)

```bash tab="Backup"
# Backup procedure

# Parameter `--format custom` is used to specify the usage of psql custom format
pg_dump \
    --verbose \
    --format custom --compress 9 \
    --schema-only \
    --table calendar_union_v1 \
    --table calendar_v1 \
    --table connectors_config_v1 \
    --table connectors_executions_log_v1 \
    --table elasticsearch_indices_v1 \
    --table fact_baseline_definition_v1 \
    --table fact_baseline_v1 \
    --table fact_definition_v1 \
    --table fact_history_v1 \
    --table interaction_history_v1 \
    --table issue_detection_feedback_v3 \
    --table issue_resolution_draft_v1 \
    --table issue_resolution_v1 \
    --table issues_v1 \
    --table job_schedules_v1 \
    --table model_v1 \
    --table notifications_history_v1 \
    --table ref_action_v1 \
    --table ref_rootcause_v1 \
    --table rule_versions_v1 \
    --table rules_v1 \
    --table situation_definition_v1 \
    --table situation_facts_v1 \
    --table situation_history_v1 \
    --table situation_rules_v1 \
    --table situation_template_instances_v1 \
    --table user_groups_v1 \
    --table user_memberships_v1 \
    --table users_v1 \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    ${dbname} > myrtea.schema.dump.tar

pg_dump \
    --verbose \
    --format custom --compress 9 \
    --data-only \
    --table fact_baseline_definition_v1 \
    --table fact_baseline_v1 \
    --table fact_definition_v1 \
    --table job_schedules_v1 \
    --table model_v1 \
    --table ref_action_v1 \
    --table ref_rootcause_v1 \
    --table rule_versions_v1 \
    --table rules_v1 \
    --table situation_definition_v1 \
    --table situation_facts_v1 \
    --table situation_rules_v1 \
    --table situation_template_instances_v1 \
    --table user_groups_v1 \
    --table user_memberships_v1 \
    --table users_v1 \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    ${dbname} > myrtea.data.dump.tar
```

```bash tab="Restore"
# Restoration procedure
pg_restore \
    --verbose \
    --format custom \
    --schema-only \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    --dbname ${dbname} < myrtea.schema.dump.tar

pg_restore \
    --verbose \
    --format custom \
    --data-only \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    --dbname ${dbname} < myrtea.data.dump.tar
```

```bash tab="Clean"
# Cleaning procedure
rm -f myrtea.schema.dump.tar myrtea.data.dump.tar
```

### Plain-text format

The plain-text format (raw SQL) offers less features than the custom pg_dump format described in the previous section, and thus, should be mainly used for debugging.

```bash tab="Backup"
pg_dump \
    --table fact_baseline_definition_v1 \
    --table fact_baseline_v1 \
    --table fact_definition_v1 \
    --table job_schedules_v1 \
    --table model_v1 \
    --table ref_action_v1 \
    --table ref_rootcause_v1 \
    --table rule_versions_v1 \
    --table rules_v1 \
    --table situation_definition_v1 \
    --table situation_facts_v1 \
    --table situation_rules_v1 \
    --table situation_template_instances_v1 \
    --table user_groups_v1 \
    --table user_memberships_v1 \
    --table users_v1 \
    --username ${username} \
    ${dbname} > dump.sql
```

```bash tab="Restore"
# Command `psql` must be used in this case
psql \
    --username ${username} \
    ${dbname} < dump.sql
```

## Full dump (for support and debugging purpose)

```bash tab="Backup"
# Backup procedure
pg_dump \
    --verbose \
    --format custom --compress 9 \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    ${dbname} > myrtea.full.dump.tar
```

```bash tab="Restore"
# Restoration procedure
pg_restore \
    --verbose \
    --format custom \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    --dbname ${dbname} < myrtea.full.dump.tar
```
