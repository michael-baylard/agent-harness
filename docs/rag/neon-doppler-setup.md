# Neon + Doppler setup for research embeddings

> _Last updated: 2026-09-09_

Wire secrets and schema once per machine/account. Consuming repos copy this pattern into their own Doppler project.

## 1. Neon

1. Create project at [neon.tech](https://neon.tech) (free tier works for harness research).
2. Enable **pgvector** — run migration [`../../migrations/001_harness_embeddings.sql`](../../migrations/001_harness_embeddings.sql) on your branch.
3. Copy connection string → Doppler as `DATABASE_URL`.

**Branch strategy:** `main` for prod corpus; dev branch for experiments.

## 2. Doppler

Create a Doppler project (e.g. `agent-harness` / config `prd`) or reuse an existing personal project:

```powershell
doppler secrets set DATABASE_URL="postgresql://..." --project agent-harness --config prd
doppler secrets set VOYAGE_API_KEY="pa-..." --project agent-harness --config prd
# Optional — chat over retrieved chunks
doppler secrets set ANTHROPIC_API_KEY="sk-..." --project agent-harness --config prd
```

Local fallback (gitignored):

```powershell
doppler secrets download --no-file --format env --project agent-harness --config prd > .env.local
```

Never commit `.env.local`.

## 3. Voyage embeddings

| Model | Dims | Use |
|-------|------|-----|
| `voyage-4` | 1024 | Default for markdown research docs |
| `voyage-4-lite` | 512 | Cheaper; lower recall |

API: [docs.voyageai.com](https://docs.voyageai.com/docs/embeddings)

```python
# Minimal embed call (illustrative)
import voyageai
vo = voyageai.Client()  # VOYAGE_API_KEY from env
result = vo.embed(["chunk text"], model="voyage-4", input_type="document")
vector = result.embeddings[0]  # 1024 floats
```

## 4. Cursor MCP profile (research + RAG)

Enable **≤6** servers for embedding workflows:

| MCP | Role |
|-----|------|
| **Neon** | Run migration, INSERT embeddings, semantic SQL |
| **Context7** | Library docs (not your research corpus) |
| **GitHub** | Issue/spec workflow |

Disable scrape/search MCPs unless doing live web research in same session.

Neon MCP docs: [neon.tech/docs/ai/neon-mcp-server](https://neon.tech/docs/ai/neon-mcp-server)

## 5. Ingest workflow

### A. Manual / MCP (no scripts)

1. Chunk markdown (~500–800 tokens, overlap 80).
2. Embed via Voyage API.
3. `INSERT INTO harness_embeddings (...)` via Neon MCP.

Good for <20 files.

### B. Optional script

```powershell
doppler run --project agent-harness --config prd -- python scripts/embed-markdown.py --corpus research --glob "docs/**/*.md"
```

Idempotent on `content_hash`. See script header for deps (`voyageai`, `psycopg`).

## 6. Verify

```sql
SELECT corpus_id, COUNT(*) AS chunks, MAX(embedded_at) AS latest
FROM harness_embeddings
GROUP BY corpus_id;
```

Agent test: skill `research-rag` with query "when to use semaphores vs mutex"

## 7. Security

- `DATABASE_URL` is write-capable — private repo only
- Scope `corpus_id` per project; never mix client corpora in one table without `WHERE`
- Law/medical verticals: consider on-prem embed ([concurrency doc](../research/concurrency-and-systems.md) — deployment tier, not harness default)
