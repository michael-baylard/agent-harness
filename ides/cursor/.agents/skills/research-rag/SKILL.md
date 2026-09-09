---
name: research-rag
description: Queries embedded research docs in Neon pgvector via semantic search. Use when the corpus is embedded and grep is insufficient. Do not use when RAG is not configured or for live web research.
last_updated: 2026-09-09
---

# Research RAG

Semantic search over embedded markdown in Neon `harness_embeddings`.

## Prerequisites

- [`docs/rag/neon-doppler-setup.md`](../../docs/rag/neon-doppler-setup.md) completed
- Neon MCP enabled in Cursor
- Corpus ingested (`embed-markdown.py` or manual INSERT)

## Process

1. Confirm `config/rag.yaml` or `config/rag.template.yaml` — `corpus_id`, `top_k`.
2. Embed the **user question** with Voyage (`input_type="query"`) or use nearest MCP.
3. Run similarity SQL via **Neon MCP**:

```sql
SELECT source, chunk_index, left(content, 400) AS excerpt,
       1 - (embedding <=> $query_vector::vector) AS score
FROM harness_embeddings
WHERE corpus_id = 'research'
ORDER BY embedding <=> $query_vector::vector
LIMIT 8;
```

4. Read full `source` files only for top 2–3 hits above `min_score` (default 0.72).
5. Answer with citations: `` `docs/path.md` `` — never invent paths not in results.

## When to fall back

| Situation | Use instead |
|-----------|-------------|
| RAG not set up | `rg` + skill `fast-ops` |
| Need current web data | Exa/Tavily MCP |
| <30 markdown files | Direct `@` file reads |

## Security

- Never log `DATABASE_URL` or API keys
- Scope queries with `WHERE corpus_id = ...`
