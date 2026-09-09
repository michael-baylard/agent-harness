---
name: github-actions
description: GitHub Actions workflows — CI/CD YAML, reusable workflows, OIDC deploy, secrets, and runners. Use when editing .github/workflows/ or composite actions.
last_updated: 2026-09-09
---

# GitHub Actions

## Official docs

| Topic | URL |
|-------|-----|
| Actions docs | https://docs.github.com/en/actions |
| Workflow syntax | https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions |
| Security hardening | https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions |
| OIDC to cloud | https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect |

## Agent rules

1. **Pin actions** — use SHA pins or semver tags (`actions/checkout@v4`), never `@main`.
2. **Least privilege** — `permissions:` block at workflow or job level; default read-only.
3. **Secrets** — reference `${{ secrets.NAME }}`; never echo or log secret values.
4. **Concurrency** — add concurrency groups for deploy workflows to prevent double-ship.
5. **Path filters** — skip expensive jobs when only docs or unrelated paths change.
6. **Match repo patterns** — copy structure from existing workflows before inventing new ones.
7. **Reusable workflows** — extract shared jobs when 2+ workflows duplicate steps.

## Production patterns

```yaml
permissions:
  contents: read

concurrency:
  group: deploy-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'
```

## MCP hint

**GitHub MCP** — workflow run status, PR checks, issue ops. Not for authoring YAML.

## Pairs with

- `docker` — build/push image in CI
- `playwright` — E2E in CI with artifact upload on failure
- `terraform` — plan in PR, apply on protected branch only

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `pull_request_target` without review | Understand fork PR risk first |
| Unpinned third-party actions | SHA pin from release tag |
| Long-running jobs on every push | `paths:` / `paths-ignore:` filters |
| `continue-on-error` on ship gates | Fail fast; scoped verify for pre-existing |
