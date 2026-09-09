# Harness persona fit by org size

> _Last updated: 2026-09-09_

Personas are **install-time presets** (which rules, skills, MCP profile, and delegate depth land), not three copies of every file.

## Matrix

| Surface | FAANG-scale / large tech | Growth startup | Solo / indie |
|---------|--------------------------|----------------|--------------|
| **Rules** | Compliance gates, blast-radius, no-secrets, monorepo path scoping | Ship-check, convention-matching, plan-before-code at 3+ files | Minimal: voice, paths, commit-only-when-asked |
| **Skills** | Terraform, K8s, AWS, Docker, Databricks, Snowflake, dbt, Postgres/Neon | GHA, Docker, Next.js, Playwright, Vercel, Terraform, BigQuery | GHA + Docker + Next.js (add stack skill as needed) |
| **MCP profile** | ≤4 servers, allowlist; Neon for schema | Task profiles per sprint (web / data / backend) | 2–3 servers: Context7 + Vercel or Neon |
| **Delegates** | adversarial-verifier + code-review before merge | planner → executor; single review pass | One fast explorer; skip adversarial loops |

## Presets

| Preset | File | Install |
|--------|------|---------|
| Enterprise tech | [`config/persona-presets/enterprise-tech.yaml`](../../config/persona-presets/enterprise-tech.yaml) | `install.ps1 -Ide cursor -Persona enterprise-tech` |
| Startup tech | [`config/persona-presets/startup-tech.yaml`](../../config/persona-presets/startup-tech.yaml) | `install.ps1 -Ide cursor -Persona startup-tech` |
| Indie dev | [`config/persona-presets/indie-dev.yaml`](../../config/persona-presets/indie-dev.yaml) | `install.ps1 -Ide cursor -Persona indie-dev` |

## Platform skill priority by persona

| Persona | S-tier focus at install |
|---------|-------------------------|
| Enterprise | terraform, aws, kubernetes, docker, github-actions, databricks, snowflake, dbt, postgres, neon |
| Startup | github-actions, docker, nextjs, playwright, vercel, terraform, aws, postgres, neon |
| Indie | github-actions, docker, nextjs |

Full catalog (17 skills): [`platform-skills/index.yaml`](../../platform-skills/index.yaml) · Live hub: [klarix.ai/harness/platforms](https://klarix.ai/harness/platforms)

## MCP-native platforms

| Platform | ROI | Route |
|----------|:---:|-------|
| Neon | S | Official Neon MCP — schema SQL, migrations |
| Vercel | S | Official Vercel MCP — deploy, env, logs |
| Stripe | A | Official Stripe MCP — billing ops |

Harness skills are **routing stubs** — they tell agents to use the MCP, not duplicate API wrappers.

## Enterprise wedge (roadmap)

Large tech needs an **auditable policy layer**: declarative allow/deny for tools, paths, and MCP servers with a log. Build after platform catalog v1 ships.
