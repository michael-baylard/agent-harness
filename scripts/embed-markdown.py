#!/usr/bin/env python3
"""Optional: embed markdown into Neon harness_embeddings. Requires voyageai + psycopg.

Usage:
  doppler run -- python scripts/embed-markdown.py --corpus research --glob "docs/**/*.md"
  doppler run -- python scripts/embed-markdown.py --dry-run --glob "docs/research/*.md"

Env: DATABASE_URL, VOYAGE_API_KEY (via Doppler or .env.local)
"""

from __future__ import annotations

import argparse
import hashlib
import os
import sys
from glob import glob
from pathlib import Path

CHUNK_CHARS = 2400
OVERLAP_CHARS = 320


def chunk_text(text: str) -> list[str]:
    if len(text) <= CHUNK_CHARS:
        return [text.strip()] if text.strip() else []
    chunks: list[str] = []
    start = 0
    while start < len(text):
        end = min(start + CHUNK_CHARS, len(text))
        piece = text[start:end].strip()
        if piece:
            chunks.append(piece)
        if end >= len(text):
            break
        start = end - OVERLAP_CHARS
    return chunks


def content_hash(content: str) -> str:
    return hashlib.sha256(content.encode("utf-8")).hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser(description="Embed markdown into Neon pgvector")
    parser.add_argument("--corpus", default="research", help="corpus_id column value")
    parser.add_argument("--glob", default="docs/**/*.md", help="glob from repo root")
    parser.add_argument("--root", default=".", help="repo root")
    parser.add_argument("--model", default="voyage-4")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    pattern = str(root / args.glob)
    files = sorted(glob(pattern, recursive=True))
    if not files:
        print(f"No files match {pattern}", file=sys.stderr)
        return 1

    records: list[tuple[str, str, int, str, str]] = []
    for fpath in files:
        rel = Path(fpath).relative_to(root).as_posix()
        text = Path(fpath).read_text(encoding="utf-8", errors="replace")
        for i, chunk in enumerate(chunk_text(text)):
            h = content_hash(chunk)
            records.append((args.corpus, rel, i, chunk, h))

    print(f"Found {len(files)} files -> {len(records)} chunks")
    if args.dry_run:
        for r in records[:5]:
            print(f"  {r[1]}#{r[2]} ({len(r[3])} chars)")
        if len(records) > 5:
            print(f"  ... +{len(records) - 5} more")
        return 0

    db_url = os.environ.get("DATABASE_URL")
    if not db_url:
        print("DATABASE_URL not set", file=sys.stderr)
        return 1

    try:
        import voyageai
        import psycopg
    except ImportError:
        print("Install: pip install voyageai psycopg[binary]", file=sys.stderr)
        return 1

    vo = voyageai.Client()
    texts = [r[3] for r in records]
    batch_size = 32
    all_embeddings: list[list[float]] = []
    for i in range(0, len(texts), batch_size):
        batch = texts[i : i + batch_size]
        result = vo.embed(batch, model=args.model, input_type="document")
        all_embeddings.extend(result.embeddings)

    inserted = 0
    with psycopg.connect(db_url) as conn:
        with conn.cursor() as cur:
            for (corpus, source, idx, content, h), emb in zip(records, all_embeddings):
                cur.execute(
                    """
                    INSERT INTO harness_embeddings
                      (corpus_id, source, chunk_index, content, content_hash, embedding, model)
                    VALUES (%s, %s, %s, %s, %s, %s::vector, %s)
                    ON CONFLICT (corpus_id, content_hash) DO NOTHING
                    """,
                    (corpus, source, idx, content, h, emb, args.model),
                )
                inserted += cur.rowcount
        conn.commit()

    print(f"Inserted {inserted} new chunks ({len(records) - inserted} unchanged)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
