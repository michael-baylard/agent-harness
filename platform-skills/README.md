# Platform skills (Pro stack packs)

Optional domain skills for data, ML, cloud, and CI platforms. Synced into `.agents/skills/` (and `.cursor/skills/` on Cursor install) alongside core harness skills.

| Skill | Domain | ROI |
|-------|--------|:---:|
| `terraform` | IaC, modules, state | S |
| `aws` | IAM, services, Well-Architected | S |
| `kubernetes` | Manifests, Helm, ops | S |
| `github-actions` | CI/CD workflows | A |
| `databricks` | Spark, Unity Catalog | A |
| `snowflake` | SQL, governance | A |
| `gcp-bigquery` | BigQuery SQL, slots, cost | B |
| `mlflow` | Tracking, registry, deploy | B |

Catalog: [`index.yaml`](index.yaml) · Persona fit: [`docs/platforms/persona-fit.md`](../docs/platforms/persona-fit.md)

**Live docs:** prefer Context7 MCP or official URLs in each `SKILL.md`. Do not embed vendor doc corpora in Neon without a customer contract.

Install: `install.ps1` copies platform skills automatically. Rebuild IDE adapters: `pwsh -File scripts/build-ides.ps1`.
