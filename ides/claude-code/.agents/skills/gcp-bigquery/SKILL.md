---
name: gcp-bigquery
description: Google Cloud BigQuery — SQL dialect, slots, partitioning, cost controls. Use for BigQuery SQL, scheduled queries, and data warehouse tasks on GCP.
last_updated: 2026-09-09
---

# GCP BigQuery

## Official docs

| Topic | URL |
|-------|-----|
| BigQuery docs | https://cloud.google.com/bigquery/docs |
| SQL reference | https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax |
| Cost control | https://cloud.google.com/bigquery/docs/best-practices-costs |
| IAM | https://cloud.google.com/bigquery/docs/access-control |

## Agent rules

1. **Partition and cluster** — filter on partition columns; avoid full table scans on large tables.
2. **Bytes processed** — estimate cost; use `dry_run` or `maximum_bytes_billed` in scripts.
3. **Standard SQL** — default dialect; legacy SQL only if repo already uses it.
4. **Datasets & locations** — match regional constraints (US/EU multi-region rules).
5. **Service accounts** — workload identity / SA keys via Secret Manager, not git.

## Context7

Use Context7 MCP for BigQuery client libraries (Python `google-cloud-bigquery`, Node).

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| SELECT * on TB tables | Column pruning + partitions |
| No slot/project caps in CI | Query limits in test jobs |
| Cross-region copies | Colocate datasets and GCS buckets |
