---
name: helm
description: Helm — Kubernetes package manager, charts, values, and releases. Use when editing Chart.yaml, templates/, or helm upgrade/install flows.
last_updated: 2026-09-09
---

# Helm

## Official docs

| Topic | URL |
|-------|-----|
| Helm docs | https://helm.sh/docs |
| Chart template guide | https://helm.sh/docs/chart_template_guide |
| Best practices | https://helm.sh/docs/chart_best_practices |

## Agent rules

1. **Values over template forks** — environment diffs live in `values.yaml` / `values-*.yaml`, not duplicated templates.
2. **Release naming** — match cluster conventions; document `--namespace` and `--install`.
3. **Lint before ship** — `helm lint ./chart` and `helm template` dry-run before upgrade.
4. **Secrets** — External Secrets Operator or sealed secrets; never plain text in values committed to git.
5. **Pair with kubernetes skill** — raw manifests vs Helm ownership must be clear in repo.

## Common tasks

```powershell
helm lint ./chart
helm template release ./chart -f values.yaml
helm upgrade --install release ./chart -f values.prod.yaml
```

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `latest` image tags in values | Digest or semver pin |
| Logic-heavy templates | Keep templates thin; logic in app or operators |
| Helm + raw duplicate resources | One source of truth per resource |
