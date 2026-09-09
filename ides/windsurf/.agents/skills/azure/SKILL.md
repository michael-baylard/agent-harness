---
name: azure
description: Microsoft Azure — resource groups, IAM, ARM/Bicep, and Well-Architected patterns. Use when editing Azure infra, SDK calls, or Entra ID app registrations. Prefer Context7 for ARM schema details.
last_updated: 2026-09-09
---

# Azure

## Official docs

| Topic | URL |
|-------|-----|
| Documentation hub | https://learn.microsoft.com/en-us/azure/ |
| Well-Architected | https://learn.microsoft.com/en-us/azure/well-architected/ |
| Bicep | https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/ |
| Entra ID | https://learn.microsoft.com/en-us/entra/identity/ |

## Agent rules

1. **Subscription + resource group scope** — confirm target sub/RG before naming resources.
2. **Managed identity** — prefer over client secrets for app-to-Azure access.
3. **Naming** — match `{prefix}-{env}-{service}` conventions in repo.
4. **Region pairs** — note DR requirements for production workloads.
5. **Do not invent ARM API versions** — check existing templates or docs.

## Pairs with

- `terraform` — azurerm provider modules
- `kubernetes` — AKS workloads

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| Service principal secrets in git | Managed identity + Key Vault |
| Over-permissive Contributor at sub scope | RBAC per resource group |
| Hard-coded tenant/sub IDs | Parameters + Key Vault refs |
