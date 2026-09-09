# Harness persona fit by org size

> _Last updated: 2026-09-09_

Personas are **install-time presets** (which rules, skills, MCP profile, and delegate depth land), not three copies of every file.

## Matrix

| Surface | FAANG-scale / large tech | Growth startup | Solo / indie |
|---------|--------------------------|----------------|--------------|
| **Rules** | Compliance gates, blast-radius, no-secrets, monorepo path scoping | Ship-check, convention-matching, plan-before-code at 3+ files | Minimal: voice, paths, commit-only-when-asked |
| **Skills** | Terraform, K8s, AWS, Databricks, Snowflake (depth) | GitHub Actions, Terraform-lite, BigQuery, stack-specific | 2–3 max for actual stack |
| **MCP profile** | ≤4 servers, allowlist; internal docs MCP | Task profiles per sprint (web / data / backend) | 2–3 servers: Context7 + one search |
| **Delegates** | adversarial-verifier + code-review before merge | planner → executor; single review pass | One fast explorer; skip adversarial loops |

## Presets

| Preset | File | Install |
|--------|------|---------|
| Enterprise tech | [`config/persona-presets/enterprise-tech.yaml`](../../config/persona-presets/enterprise-tech.yaml) | `install.ps1 -Ide cursor -Persona enterprise-tech` |
| Startup tech | [`config/persona-presets/startup-tech.yaml`](../../config/persona-presets/startup-tech.yaml) | `install.ps1 -Ide cursor -Persona startup-tech` |
| Indie dev | [`config/persona-presets/indie-dev.yaml`](../../config/persona-presets/indie-dev.yaml) | `install.ps1 -Ide cursor -Persona indie-dev` |

## Enterprise wedge (roadmap)

Large tech needs an **auditable policy layer**: declarative allow/deny for tools, paths, and MCP servers with a log. Build after the eight platform skills ship, not before.

## Platform skill priority by persona

| Persona | Ship first |
|---------|------------|
| Enterprise | terraform, aws, kubernetes, databricks, snowflake |
| Startup | github-actions, terraform, aws, gcp-bigquery |
| Indie | github-actions + one cloud skill matching stack |

Catalog: [`platform-skills/index.yaml`](../../platform-skills/index.yaml)
