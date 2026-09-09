-- Harness research embeddings — pgvector on Neon Postgres
-- Run once per Neon project/branch via Neon MCP or psql

CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS harness_embeddings (
  id            BIGSERIAL PRIMARY KEY,
  corpus_id     TEXT NOT NULL,           -- e.g. 'research', 'project-docs'
  source        TEXT NOT NULL,           -- relative path: docs/research/foo.md
  chunk_index   INT NOT NULL DEFAULT 0,
  content       TEXT NOT NULL,
  content_hash  TEXT NOT NULL,           -- sha256 of content — idempotent re-ingest
  embedding     vector(1024) NOT NULL,
  model         TEXT NOT NULL DEFAULT 'voyage-4',
  embedded_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (corpus_id, content_hash)
);

CREATE INDEX IF NOT EXISTS harness_embeddings_corpus_idx
  ON harness_embeddings (corpus_id);

CREATE INDEX IF NOT EXISTS harness_embeddings_embedding_idx
  ON harness_embeddings
  USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

COMMENT ON TABLE harness_embeddings IS
  'Semantic search over harness research/docs. Query with cosine distance (<=>).';
