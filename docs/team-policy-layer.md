# Team policy layer

> _Last updated: 2026-09-15_

Declarative control for **Team** orgs (YAML in git). Not SSO, DRM, or phone-home. **CI retainers off this spec.** Solo **$49 once** = one seat, no org policy.

**Locks:** Solo **$49 once** · Team **$199 / $497** mo.

## Threat

A Team org agent **must not**:

| Deny | Why |
|------|-----|
| Read/write secrets (`.env*`, Doppler tokens, `credentials*`, PEM/keys) | Exfil |
| Enable MCP outside the named profile, or exceed **6** (sqz/TracePulse excluded) | Sprawl |
| Write outside `path_write`, or into unlisted sibling repos | Blast radius |
| `git commit/push --no-verify`, force-push `main`/`master` | Bypass gate |
| Install marketplace skill dumps or extra MCP mid-session | Unreviewed |
| Continue after auto-compact | Lost policy |
| Persist customer PII or licensed contact rows | Data leak |

Conventions live in rules/skills — not MCP.

## Allowlist shape

One file per consuming repo: `config/team-policy.yaml` (name locked). Shape only — no runtime here.

```yaml
org: acme
seats: 5                    # 5 or 15 — must match SKU
mcp:
  max_servers: 6            # exclude token-only (sqz, TracePulse)
  profiles:                 # enable exactly one per session
    web: [context7, github, vercel]
    backend: [context7, neon, github]
    research: [tavily, exa, context7]
    ops: [github, vercel]
path_write: ["src/**", "docs/**", "config/**", "scripts/**"]
path_deny: ["**/.env*", "**/credentials*", "**/*.pem", "**/*doppler*"]
```

MCP names are **lowercase**, matching `config/mcp-profiles/*.yaml`. One profile per session. Unknown server = deny. This file is the org overlay; per-session enable lists stay in `config/mcp-profiles/`.

**CI-retainer denylist** (must not appear as keys or values): `ci_retainer`, `ci_monthly`, `starter_monthly`, `growth_monthly`, `scale_monthly`, `2997`, `4997`, `8997`.

## Audit

Append-only. **Do not** log secrets, file bodies, or full prompts.

| Field | When |
|-------|------|
| `ts`, `actor` (GitHub seat), `repo`, `sku` | Session start |
| `profile`, MCP names enabled | Profile bind |
| `path`, `deny_reason` | Path or MCP deny |
| `ship_check` pass/fail | Verify gate |
| `compacted: true` | Must hand off |

Retention: Team 5 = **30 days**. Team 15 = **90 days**.

## SKU

| | Team 5 **$199/mo** | Team 15 **$497/mo** |
|---|---|---|
| GitHub seats | **5** | **15** |
| Org policy file + this spec | ✅ | ✅ |
| Named MCP profiles (≤6 servers each) | ≤4 profiles | ≤8 profiles |
| Audit retention | 30 days | 90 days |
| Quarterly stack refresh | ✅ | ✅ |
| SSO / IdP / Enterprise audit | — | — |

Same engine. Deltas = seats + profile cap + retention. Enterprise (SSO) is a later SKU.

## Verify

```powershell
pwsh -File scripts/verify-team-policy.ps1   # from agent-harness repo root
```

Pass = YAML parses, `seats` ∈ {5,15}, profile count ≤4 (Team 5) or ≤8 (Team 15), each profile ≤6 servers (sqz/TracePulse excluded), MCP names lowercase, `path_deny` covers `.env*` / `credentials*` / `*.pem`, no CI-retainer keys (see denylist above).
