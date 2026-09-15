---
name: dbt
description: dbt — models, tests, sources, macros, and analytics engineering conventions. Use when editing models/, seeds/, snapshots/, or dbt_project.yml.
last_updated: 2026-09-09
---

# dbt

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://docs.getdbt.com |
| Best practices | https://docs.getdbt.com/best-practices |
| dbt agent skills (official) | https://github.com/dbt-labs/dbt-agent-skills |
| Agent skills blog | https://docs.getdbt.com/blog/dbt-agent-skills |

## Agent rules

1. **ref / source** — always use `{{ ref('model') }}` and `{{ source() }}`; never hard-code raw table names in marts.
2. **Tests on every model** — at minimum `unique` + `not_null` on primary keys in marts.
3. **Staging → intermediate → mart** — match existing layer naming in the project.
4. **Materialization** — follow project defaults; do not switch to table/incremental without cost note.
5. **Cross-ref official skills** — dbt Labs publishes marketplace skills; this harness skill adds guardrails + routing, not a duplicate corpus.

## Common tasks

```powershell
dbt debug
dbt run --select model_name
dbt test --select model_name
dbt build
```

## Pairs with

- `snowflake`, `postgres`, `gcp-bigquery`, `databricks` — warehouse-specific SQL dialect
- `github-actions` — CI `dbt build` on PR

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| SELECT * in production models | Explicit columns + contract |
| Business logic only in BI tool | Document in dbt marts |
| Skipping `schema.yml` | Column descriptions + tests |
