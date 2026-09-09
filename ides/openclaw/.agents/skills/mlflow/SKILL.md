---
name: mlflow
description: MLflow — experiment tracking, model registry, projects, and deployment hooks. Use when editing tracking code, registry tags, or ML pipeline configs.
last_updated: 2026-09-09
---

# MLflow

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://mlflow.org/docs/latest/index.html |
| Tracking | https://mlflow.org/docs/latest/tracking.html |
| Model Registry | https://mlflow.org/docs/latest/model-registry.html |
| Projects | https://mlflow.org/docs/latest/projects.html |

## Agent rules

1. **Experiment naming** — follow repo convention (`{project}/{env}/{task}`).
2. **Artifacts** — log params, metrics, and artifacts; do not log secrets or raw PII.
3. **Registry stages** — Staging → Production transitions need explicit promotion notes.
4. **Backend store** — respect configured tracking URI (local, Databricks, remote server).
5. **Reproducibility** — log git commit, conda/pip env, and data version when repo does.

## Pairs with

- `databricks` — managed MLflow on Databricks workspaces

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| Logging huge artifacts every step | Sample or aggregate |
| Overwriting production model silently | Registry version + alias |
| Local-only tracking in team repos | Shared tracking server |
