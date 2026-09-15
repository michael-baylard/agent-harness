---
name: neon
description: Neon Postgres MCP — schema-aware SQL, migrations, branches, and serverless Postgres ops. Use when DATABASE_URL points at Neon or Neon MCP is in the active profile.
last_updated: 2026-09-09
---

# Neon (MCP-native)

## Official docs

| Topic | URL |
|-------|-----|
| Neon MCP server | https://neon.tech/docs/ai/neon-mcp-server |
| Branching | https://neon.tech/docs/introduction/branching |

## Agent rules

1. **MCP over files** — prefer `run_sql`, `describe_table_schema`, `prepare_database_migration` over hand-written one-off SQL files when MCP is enabled.
2. **Write mode** — destructive MCP tools require explicit user approval; never auto-run deletes.
3. **Schema doc sync** — after migration, update project `neon-schema.md` and pipeline `columns.yaml` if applicable.
4. **Profile budget** — counts toward ≤6 MCP servers; enable in `pipeline` or `web` profile, not all at once.
5. **Pair with postgres skill** — SQL dialect and migration patterns live there; this skill is routing + MCP policy.

## Do not

- Embed full Neon doc corpus in custom RAG without contract
- Duplicate Neon MCP with raw `psql` scripts when MCP is available
