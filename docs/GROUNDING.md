# Grounding — factual claims and retrieval

> _Last updated: 2026-09-09_ · Aligns with Google-style agent grounding: **retrieve before assert**, **cite or mark unknown**.

## Rules (every agent session)

| Rule | Do |
|------|-----|
| **Tool-first** | Use MCP/search/RAG before stating live facts (prices, APIs, company data, schema). |
| **Cite sources** | URLs for web claims; file paths for repo claims; SQL/table names for DB claims. |
| **Explicit unknowns** | Say "not verified" instead of guessing. |
| **No training-data authority** | Library syntax → Context7 or official docs, not memory. |
| **Grounded outputs only** | Research docs in `docs/research/` are corpus, not permission to invent new "research." |

## MCP retrieval order (research profile)

1. **Repo disk** — `rg` / Read / `sqz_read_file`
2. **Cheap SERP** — Serper (volume)
3. **Page extract** — Tavily or Exa (one, not both)
4. **Browser** — Obscura only when fetch fails or page is dynamic
5. **DB** — Neon MCP for schema/data

## Pro RAG (Neon + Voyage)

- Embed only markdown you control (`docs/rag/`).
- Answers must quote chunk IDs or paths when used in customer-facing copy.
- Re-ingest after doc changes; stale embeddings = ungrounded answers.

## Anti-patterns

| Bad | Good |
|-----|------|
| "Stripe product ID is probably …" | Read Doppler/env or Stripe MCP |
| Invent portal slugs | `PORTAL-CONVENTIONS.md` / Neon describe |
| Uncited competitor claims | Serper → extract → URL on every fact |

## Harness ship gate

Before claiming done: run `ship-check`, scoped verify, and for factual deliverables run pipeline/skills — not chat synthesis.
