# PostgreSQL tables

## Schema

[Schema PNG]

## List of tables

> Tables are created and migrated automatically by the Engine API on startup (using [pressly/goose](https://github.com/pressly/goose)).  
> Migration files live in `migrations/` in the engine-api repo, starting at `00401_myrtea_schema_v401.sql`.

| Table                                    | Packaged ? | Description |
| ---------------------------------------- | ---------- | ----------- |
| `api_keys`                               | Yes        | API key credentials (hashed) for programmatic access. |
| `calendar_union_v1`                      | Yes        | Calendar unions (composite calendars). |
| `calendar_v1`                            | Yes        | Calendar definitions used by cron scheduling. |
| `config_history_v1`                      | No(*)      | Audit log of configuration changes (timestamp-keyed). |
| `connectors_config_v1`                   | Yes        | Connector configurations. |
| `connectors_executions_log_v1`           | No(*)      | Connector execution history. |
| `elasticsearch_indices_v1`               | Yes        | Index template definitions managed by Myrtea. |
| `external_config_folders_v1`             | Yes        | Folder hierarchy for external configuration items. |
| `external_generic_config_v1`             | Yes        | Untyped (JSON) external configuration entries. |
| `external_generic_config_versions_v1`    | No(*)      | Historical versions of external config entries. |
| `fact_baseline_definition_v1`            | Yes        | Baseline definitions for fact evaluation. |
| `fact_baseline_v1`                       | Yes        | Computed baseline values. |
| `fact_definition_v1`                     | Yes        | Fact definitions. |
| `fact_history_v5`                        | No(*)      | Computed fact history (replaces `fact_history_v1`). |
| `functional_situation_v1`                | Yes        | Functional situation definitions (logical views over situations). |
| `functional_situation_instances_v1`      | Yes        | Links between functional situations and situation template instances. |
| `functional_situation_situations_v1`     | Yes        | Links between functional situations and standalone situations. |
| `interaction_history_v1`                 | No(*)      | User interaction history (issue actions). |
| `issue_detection_feedback_v3`            | No(*)      | User feedback on detected issues. |
| `issue_resolution_draft_v1`              | No(*)      | Draft resolutions for issues. |
| `issue_resolution_v1`                    | No(*)      | Committed issue resolutions. |
| `issues_v1`                              | No(*)      | Detected issue log. |
| `job_schedules_v1`                       | Yes        | Scheduled job definitions (crons). |
| `mail_templates_v1`                      | Yes        | Email notification templates. |
| `model_v1`                               | Yes        | Elasticsearch index models. |
| `notifications_history_v1`               | No(*)      | Notification delivery history. |
| `ref_action_v1`                          | Yes        | Reference action definitions. |
| `ref_rootcause_v1`                       | Yes        | Root cause reference definitions. |
| `rule_versions_v1`                       | Yes        | Versioned rule snapshots. |
| `rules_v1`                               | Yes        | Rule definitions. |
| `situation_definition_v1`                | Yes        | Situation definitions. |
| `situation_facts_v1`                     | Yes        | Associations between situations and facts. |
| `situation_history_v1`                   | No(*)      | Computed situation history. |
| `situation_rules_v1`                     | Yes        | Associations between situations and rules. |
| `situation_template_instances_v1`        | Yes        | Situation template instances. |
| `tags_v1`                                | Yes        | Tag definitions for labelling resources. |
| `user_groups_v1`                         | Yes        | User group definitions. |
| `user_memberships_v1`                    | Yes        | User ↔ group memberships. |
| `users_v1`                               | Yes        | User accounts (BASIC auth mode). |
| `variables_config_v1`                    | Yes        | Key-value variable store for dynamic configuration. |

*(\*) Tables related to issue history, usage history, computation history, or feedback are not packaged to avoid side effects during deployment to another environment.*

## Application packaging

### Custom format (binary, non human-readable)

```bash tab="Backup"
# Backup procedure

# Parameter `--format custom` is used to specify the usage of psql custom format
pg_dump \
    --verbose \
    --format custom --compress 9 \
    --schema-only \
    --table api_keys \
    --table calendar_union_v1 \
    --table calendar_v1 \
    --table config_history_v1 \
    --table connectors_config_v1 \
    --table connectors_executions_log_v1 \
    --table elasticsearch_indices_v1 \
    --table external_config_folders_v1 \
    --table external_generic_config_v1 \
    --table external_generic_config_versions_v1 \
    --table fact_baseline_definition_v1 \
    --table fact_baseline_v1 \
    --table fact_definition_v1 \
    --table fact_history_v5 \
    --table functional_situation_v1 \
    --table functional_situation_instances_v1 \
    --table functional_situation_situations_v1 \
    --table interaction_history_v1 \
    --table issue_detection_feedback_v3 \
    --table issue_resolution_draft_v1 \
    --table issue_resolution_v1 \
    --table issues_v1 \
    --table job_schedules_v1 \
    --table mail_templates_v1 \
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
    --table tags_v1 \
    --table user_groups_v1 \
    --table user_memberships_v1 \
    --table users_v1 \
    --table variables_config_v1 \
    --host ${hostname} \
    --port ${port} \
    --username ${username} \
    ${dbname} > myrtea.schema.dump.tar

pg_dump \
    --verbose \
    --format custom --compress 9 \
    --data-only \
    --table api_keys \
    --table calendar_union_v1 \
    --table calendar_v1 \
    --table connectors_config_v1 \
    --table elasticsearch_indices_v1 \
    --table external_config_folders_v1 \
    --table external_generic_config_v1 \
    --table fact_baseline_definition_v1 \
    --table fact_baseline_v1 \
    --table fact_definition_v1 \
    --table functional_situation_v1 \
    --table functional_situation_instances_v1 \
    --table functional_situation_situations_v1 \
    --table job_schedules_v1 \
    --table mail_templates_v1 \
    --table model_v1 \
    --table ref_action_v1 \
    --table ref_rootcause_v1 \
    --table rule_versions_v1 \
    --table rules_v1 \
    --table situation_definition_v1 \
    --table situation_facts_v1 \
    --table situation_rules_v1 \
    --table situation_template_instances_v1 \
    --table tags_v1 \
    --table user_groups_v1 \
    --table user_memberships_v1 \
    --table users_v1 \
    --table variables_config_v1 \
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
    --table api_keys \
    --table calendar_union_v1 \
    --table calendar_v1 \
    --table connectors_config_v1 \
    --table elasticsearch_indices_v1 \
    --table external_config_folders_v1 \
    --table external_generic_config_v1 \
    --table fact_baseline_definition_v1 \
    --table fact_baseline_v1 \
    --table fact_definition_v1 \
    --table functional_situation_v1 \
    --table functional_situation_instances_v1 \
    --table functional_situation_situations_v1 \
    --table job_schedules_v1 \
    --table mail_templates_v1 \
    --table model_v1 \
    --table ref_action_v1 \
    --table ref_rootcause_v1 \
    --table rule_versions_v1 \
    --table rules_v1 \
    --table situation_definition_v1 \
    --table situation_facts_v1 \
    --table situation_rules_v1 \
    --table situation_template_instances_v1 \
    --table tags_v1 \
    --table user_groups_v1 \
    --table user_memberships_v1 \
    --table users_v1 \
    --table variables_config_v1 \
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
