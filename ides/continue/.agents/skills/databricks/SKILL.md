---
name: databricks
description: Databricks — Spark, notebooks, Unity Catalog, jobs, and SQL warehouses. Use for data engineering and ML on Databricks workspaces.
last_updated: 2026-09-09
---

# Databricks

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://docs.databricks.com |
| Unity Catalog | https://docs.databricks.com/en/data-governance/unity-catalog/index.html |
| Jobs | https://docs.databricks.com/en/workflows/jobs/jobs.html |
| ML | https://docs.databricks.com/en/machine-learning/index.html |

## Agent rules

1. **Unity Catalog** — use three-level names (`catalog.schema.table`) when UC is enabled.
2. **Cluster policy** — do not upsize clusters without cost note; prefer job clusters for batch.
3. **Notebooks vs repos** — prefer repo-backed notebooks / Databricks Asset Bundles for prod paths.
4. **Secrets** — Databricks secrets scopes, not hard-coded tokens in notebooks.
5. **Spark SQL dialect** — not identical to ANSI SQL; verify functions against Databricks docs.

## Pairs with

- `snowflake` — federated queries / lakehouse patterns
- `mlflow` — tracking on Databricks ML

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| All-purpose cluster 24/7 | Job clusters + autoscaling |
| `display()` in production jobs | Structured logging |
| Bypassing UC for "speed" | Catalog grants + lineage |
