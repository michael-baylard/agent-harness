---
name: aws
description: Amazon Web Services — IAM, core services, Well-Architected patterns. Use for CDK, CloudFormation, SDK calls, or architecture questions. Prefer awslabs MCP when live account queries are needed and approved.
last_updated: 2026-09-09
---

# AWS

## Official docs

| Topic | URL |
|-------|-----|
| Documentation hub | https://docs.aws.amazon.com |
| Well-Architected | https://docs.aws.amazon.com/wellarchitected/ |
| IAM best practices | https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html |
| awslabs MCP | https://github.com/awslabs/mcp |

## Agent rules

1. **Least privilege IAM** — scoped actions, no `*` on production paths without explicit ask.
2. **Region awareness** — confirm region; many ARNs and endpoints are regional.
3. **Cost** — flag NAT gateways, idle EBS, oversized instances, cross-AZ data transfer.
4. **Naming** — match existing `{env}-{service}-{resource}` conventions in repo.
5. **Do not invent service APIs** — verify against docs or Context7 before codegen.

## MCP profile hint

Enable **awslabs MCP** only for read/diagnose tasks with user-approved credentials. Disable when editing unrelated code.

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| Long-lived access keys in git | IAM roles, OIDC, Secrets Manager |
| Public S3 buckets by default | Block public access + bucket policies |
| One mega IAM user | Roles per workload |
