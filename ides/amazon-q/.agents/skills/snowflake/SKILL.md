---
name: snowflake
description: Snowflake — SQL, warehouses, roles, stages, and governance. Use when editing .sql, Snowflake DDL, or data pipeline configs targeting Snowflake.
last_updated: 2026-09-09
---

# Snowflake

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://docs.snowflake.com |
| SQL reference | https://docs.snowflake.com/en/sql-reference-commands |
| Access control | https://docs.snowflake.com/en/user-guide/security-access-control-overview |
| Warehouses | https://docs.snowflake.com/en/user-guide/warehouses |

## Agent rules

1. **Role hierarchy** — least privilege; use role switching explicitly in scripts.
2. **Warehouse sizing** — note credit impact when changing warehouse size or auto-suspend.
3. **Idempotent DDL** — prefer `CREATE ... IF NOT EXISTS` / `CREATE OR REPLACE` patterns used in repo.
4. **Stages & pipes** — match existing integration (S3/GCS/Azure) naming.
5. **Dialect** — Snowflake-specific functions (`FLATTEN`, `QUALIFY`, etc.) — verify in docs.

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| ACCOUNTADMIN for app roles | Functional roles per domain |
| X-Small warehouse for heavy ETL | Right-size + auto-suspend |
| SELECT * in prod views | Explicit column lists |
