---
name: docker
description: Docker and Compose — images, multi-stage builds, devcontainers, and local service orchestration. Use when editing Dockerfile, docker-compose.yml, or .devcontainer/.
last_updated: 2026-09-09
---

# Docker

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://docs.docker.com |
| Dockerfile reference | https://docs.docker.com/reference/dockerfile/ |
| Compose | https://docs.docker.com/compose/ |
| Dev Containers | https://code.visualstudio.com/docs/devcontainers/containers |

## Agent rules

1. **Multi-stage builds** — separate build and runtime stages; pin base image digests or semver tags, not `latest`.
2. **Non-root** — run app processes as non-root when the base image allows it.
3. **Layer cache** — copy dependency manifests before source; order `COPY` for cache hits.
4. **Secrets** — never `ARG` or `ENV` for API keys; use runtime env or secret mounts.
5. **Match repo** — copy existing Dockerfile/compose patterns before inventing new service names or networks.

## Common tasks

```powershell
docker compose config
docker compose up -d --build
docker build -t app:local .
```

## Pairs with

- `kubernetes` — image tags consumed by cluster manifests
- `github-actions` — build/push in CI with OIDC to registry
- `nextjs` — standalone output + slim runtime image

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `latest` in production Dockerfile | Semver or digest pin |
| Installing dev tools in runtime stage | Multi-stage: build in builder, copy artifact |
| Publishing credentials in compose files | `.env` gitignored + env_file reference |
