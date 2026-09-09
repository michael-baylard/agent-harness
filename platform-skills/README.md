# Platform skills (Pro stack packs)

Optional domain skills for data, ML, cloud, CI, frameworks, and MCP-native platforms. Synced into `.agents/skills/` (and `.cursor/skills/` on Cursor install) alongside core harness skills.

## ROI catalog (17 skills)

| Skill | Domain | ROI |
|-------|--------|:---:|
| `terraform` | IaC, modules, state | S |
| `aws` | IAM, services, Well-Architected | S |
| `kubernetes` | Manifests, Helm, ops | S |
| `github-actions` | CI/CD workflows | S |
| `docker` | Images, compose, devcontainers | S |
| `nextjs` | App Router, RSC, deploy | S |
| `playwright` | E2E browser verification | S |
| `databricks` | Spark, Unity Catalog | S |
| `snowflake` | SQL, governance | S |
| `dbt` | Models, tests, analytics eng | A |
| `gcp-bigquery` | BigQuery SQL, slots, cost | A |
| `postgres` | Schema, migrations, SQL | A |
| `mlflow` | Tracking, registry, deploy | A |
| `azure` | ARM/Bicep, Entra, Well-Architected | A |
| `neon` | Postgres MCP (official) | S |
| `vercel` | Deploy MCP (official) | S |
| `stripe` | Billing MCP (official) | A |

**Free vs Pro:** Public MIT repo ships routing stubs (doc links + guardrails) for SEO and install. **Pro** adds RAG wiring, quarterly depth, and `pro/stacks/*` in the private repo.

Catalog: [`index.yaml`](index.yaml) · Persona fit: [`docs/platforms/persona-fit.md`](../docs/platforms/persona-fit.md) · Live hub: [klarix.ai/harness/platforms](https://klarix.ai/harness/platforms)

Install: `install.ps1` copies platform skills automatically. Rebuild IDE adapters: `pwsh -File scripts/build-ides.ps1`.
