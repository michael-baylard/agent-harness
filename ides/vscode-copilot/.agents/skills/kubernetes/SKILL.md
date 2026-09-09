---
name: kubernetes
description: Kubernetes manifests, Helm, kubectl workflows. Use when editing YAML in k8s/, helm/, or deployment configs. Validate apiVersion/kind against cluster version when known.
last_updated: 2026-09-09
---

# Kubernetes

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://kubernetes.io/docs/home/ |
| API reference | https://kubernetes.io/docs/reference/kubernetes-api/ |
| Workloads | https://kubernetes.io/docs/concepts/workloads/ |

## Agent rules

1. **Never guess apiVersion** — check cluster version or existing manifests in repo.
2. **Resources** — set requests/limits on production-bound workloads.
3. **Secrets** — use sealed-secrets, external-secrets, or cloud secret managers; not plain YAML in git.
4. **Labels/selectors** — keep app.kubernetes.io/name and instance labels consistent.
5. **Dry-run** — suggest `kubectl apply --dry-run=server` before destructive changes.

## Useful commands

```powershell
kubectl diff -f manifest.yaml
kubectl apply --dry-run=server -f manifest.yaml
helm template release ./chart
```

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `:latest` tags in prod | Immutable digests or semver tags |
| Cluster-admin for apps | Namespace-scoped RBAC |
| Config in env for large blobs | ConfigMaps / Secrets with mounts |
