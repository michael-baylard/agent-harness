---
name: terraform
description: HashiCorp Terraform and OpenTofu — modules, state, providers, and plan/apply safety. Use when editing .tf files, modules, backends, or CI that runs terraform. Route live provider schemas to Context7 MCP first.
last_updated: 2026-09-09
---

# Terraform

## Official docs

| Topic | URL |
|-------|-----|
| Core docs | https://developer.hashicorp.com/terraform/docs |
| Registry | https://registry.terraform.io |
| CLI commands | https://developer.hashicorp.com/terraform/cli/commands |
| State | https://developer.hashicorp.com/terraform/language/state |

## Agent rules

1. **Plan before apply** — never suggest `apply` without `plan` output reviewed.
2. **State is sacred** — do not rename resources or move state without explicit migration steps.
3. **Provider pins** — match existing `required_providers` versions; do not bump major without ask.
4. **Modules** — prefer existing module patterns in repo over inventing new abstractions.
5. **Secrets** — no credentials in `.tf`; use env vars, TF_VAR_, or remote secret stores.

## Common tasks

```powershell
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
```

## MCP / tools

- **Context7** — provider resource schemas (aws, google, azurerm).
- **No Terraform MCP required** — CLI + docs suffice for most agent work.

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| `terraform apply -auto-approve` in prod | Plan + human or CI gate |
| Hard-coded account IDs | Variables + tfvars per env |
| Monolithic root module | Split by domain (network, data, app) |
