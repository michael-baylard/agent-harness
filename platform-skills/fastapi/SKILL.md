---
name: fastapi
description: FastAPI — async Python APIs, Pydantic models, dependency injection, and OpenAPI. Use when editing app/routers, schemas, or ASGI deploy configs.
last_updated: 2026-09-09
---

# FastAPI

## Official docs

| Topic | URL |
|-------|-----|
| FastAPI | https://fastapi.tiangolo.com |
| Pydantic v2 | https://docs.pydantic.dev/latest/ |
| Deployment | https://fastapi.tiangolo.com/deployment/ |

## Agent rules

1. **Pydantic v2** — `model_validate`, `Field`, typed responses; match existing schema style.
2. **Async when I/O bound** — `async def` for DB/HTTP; don't block event loop with sync CPU work.
3. **Dependency injection** — reuse `Depends()` patterns from repo for auth and DB sessions.
4. **OpenAPI** — route response models explicit; don't break `/docs` contract silently.
5. **Context7** — verify FastAPI/Pydantic syntax; training data drifts on v2 migration.

## Common tasks

```powershell
uv run uvicorn app.main:app --reload
uv run pytest
```

## Pairs with

- `postgres` / `neon` — database layer
- `docker` — API container images
- `kubernetes` / `helm` — service deploy

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| Raw dict responses | Pydantic response_model |
| Global mutable state | Depends + lifespan hooks |
| Sync ORM in async route without thread pool | async driver or sync def endpoint |
