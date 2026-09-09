---
name: postgres
description: PostgreSQL — schema design, migrations, indexes, and safe SQL. Use when editing SQL migrations, ORM schemas, or query layers against Postgres.
last_updated: 2026-09-09
---

# PostgreSQL

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://www.postgresql.org/docs/current/ |
| Neon MCP | https://neon.tech/docs/ai/neon-mcp-server |
| pgvector | https://github.com/pgvector/pgvector |

## Agent rules

1. **Neon MCP first** — when enabled, use MCP for schema checks and SQL; do not guess column names from memory.
2. **Idempotent migrations** — `IF NOT EXISTS`, backward-compatible adds before destructive changes.
3. **Indexes** — justify new indexes; note write amplification on hot tables.
4. **Transactions** — multi-step writes in explicit transactions; avoid long-held locks.
5. **Secrets** — `DATABASE_URL` via Doppler or env loader; never commit connection strings.

## Pairs with

- `neon` — hosted Postgres + MCP
- `dbt` — warehouse models when Postgres is the target
- `nextjs` — server actions / API routes hitting Neon

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `SELECT *` in production API paths | Explicit columns |
| Migration without rollback plan | Expand-contract pattern |
| String-interpolated SQL | Parameterized queries |
