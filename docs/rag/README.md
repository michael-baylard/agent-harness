# Research RAG (optional)

> _Last updated: 2026-09-09_

**Status:** Optional layer — agent-harness works without it. Use when research docs exceed what `rg` + `@` files can cover (~50+ markdown files or cross-repo corpus).

## What this adds

| Without RAG | With RAG |
|-------------|----------|
| Agents grep/read markdown | Semantic search over embedded chunks |
| Zero secrets | Doppler → Voyage + Neon |
| Zero infra | pgvector table in Neon Postgres |

## Stack

```
docs/**/*.md  →  chunk  →  Voyage voyage-4  →  Neon pgvector
                              ↑                      ↑
                         Doppler prd            DATABASE_URL
```

| Secret (Doppler) | Purpose |
|------------------|---------|
| `DATABASE_URL` | Neon Postgres connection string |
| `VOYAGE_API_KEY` | Embedding API (1024-dim `voyage-4`) |
| `ANTHROPIC_API_KEY` or `OPENAI_API_KEY` | Chat over retrieved chunks (optional) |

Project/config name is **yours** — this harness does not assume Klarix's Doppler project.

## Setup order

1. [`neon-doppler-setup.md`](neon-doppler-setup.md) — Neon branch, migration, Doppler secrets, MCP profile
2. Run migration: [`../../migrations/001_harness_embeddings.sql`](../../migrations/001_harness_embeddings.sql)
3. Embed docs once (choose one):
   - **Neon MCP + manual INSERT** — small corpora
   - **Optional script:** `scripts/embed-markdown.py` (generic, not required)
4. Enable **Neon MCP** in Cursor (≤6 server profile)
5. Skill: `research-rag` — query pattern for agents

## When NOT to use RAG

- Repo has <30 research markdown files → `rg` + skill `fast-ops` is cheaper
- Secrets cannot live in Doppler → stay file-based; no embeddings
- Real-time web research → Exa/Tavily MCP, not vector store

## Query pattern (Neon MCP)

```sql
-- After embedding; $query_vector from Voyage embed API or MCP tool
SELECT source, chunk_index, content,
       1 - (embedding <=> $query_vector::vector) AS score
FROM harness_embeddings
WHERE corpus_id = 'research'
ORDER BY embedding <=> $query_vector::vector
LIMIT 8;
```

Agents: read top chunks, cite `source` path, say when corpus is stale.

## Related

- [`../research/references.md`](../research/references.md) — pgvector, Neon MCP tiers
- [`../../config/rag.template.yaml`](../../config/rag.template.yaml) — per-project config
