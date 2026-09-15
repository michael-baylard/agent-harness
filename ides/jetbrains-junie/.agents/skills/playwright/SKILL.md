---
name: playwright
description: Playwright Test — browser automation, E2E specs, trace debugging, and agent-driven verification. Use when editing tests/, e2e/, or ship-gate browser checks.
last_updated: 2026-09-09
---

# Playwright

## Official docs

| Topic | URL |
|-------|-----|
| Intro | https://playwright.dev/docs/intro |
| Best practices | https://playwright.dev/docs/best-practices |
| Test agents | https://playwright.dev/docs/test-agents |
| CI | https://playwright.dev/docs/ci |

## Agent rules

1. **Role-based locators** — `getByRole`, `getByLabel`, `getByTestId`; avoid brittle CSS/XPath.
2. **Test isolation** — each test sets up its own state; no order dependency between specs.
3. **Wait correctly** — prefer auto-waiting assertions (`toBeVisible`) over fixed `sleep`.
4. **Ship gate** — agents cannot claim UI done without running Playwright or equivalent browser verify when tests exist.
5. **Project config** — extend existing `playwright.config.ts`; do not create parallel config files.

## Common tasks

```powershell
pnpm exec playwright test
pnpm exec playwright test --ui
pnpm exec playwright codegen
```

## MCP / tools

- Playwright MCP or agent-cli skills when configured
- Otherwise run CLI from repo root per package.json scripts

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `test()` outside Playwright test runner context | Import from `@playwright/test` in spec files only |
| Hard-coded localhost ports | Use `baseURL` from config |
| Screenshots without assertion | Assert behavior, trace on failure |
