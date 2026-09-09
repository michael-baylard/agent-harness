---
name: github-actions
description: GitHub Actions workflows — CI/CD YAML, reusable workflows, secrets, and runners. Use when editing .github/workflows/ or composite actions.
last_updated: 2026-09-09
---

# GitHub Actions

## Official docs

| Topic | URL |
|-------|-----|
| Actions docs | https://docs.github.com/en/actions |
| Workflow syntax | https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions |
| Security hardening | https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions |

## Agent rules

1. **Pin actions** — use SHA pins or semver tags, not `@main`.
2. **Least privilege** — `permissions:` block at workflow or job level; default read-only.
3. **Secrets** — reference `${{ secrets.NAME }}`; never echo or log secret values.
4. **Concurrency** — add concurrency groups for deploy workflows to prevent double-ship.
5. **Match repo patterns** — copy structure from existing workflows before inventing new ones.

## MCP hint

**GitHub MCP** — useful for checking workflow run status, not for authoring YAML.

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `pull_request_target` without review | Understand fork PR risk first |
| Unpinned third-party actions | SHA pin from release tag |
| Long-running jobs on every push | path filters, `workflow_dispatch` |
