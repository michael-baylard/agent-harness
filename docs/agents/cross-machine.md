# Cross-machine harness

> _Last updated: 2026-09-09_

Same git repo on **Mac + Windows**. Machine paths live in `config/harness.yaml`, not universal docs.

## Universal (tracked in git)

| Asset | Path |
|-------|------|
| Harness hub | `HARNESS.md` · `TOOLS-ROI.md` |
| Rules | `cursor-rules/` → `install.ps1` → `.cursor/rules/` |
| Skills | `cursor-skills/` → `.cursor/skills/` |
| Docs | `docs/agents/` · `docs/research/` |
| Vendor manifest | `config/skills-vendor.yaml` |

## After `git pull`

### Windows

```powershell
cd path\to\your-project
pwsh -File path\to\agent-harness\install.ps1
```

### Mac

```bash
cd ~/GitHub/your-project
pwsh -File ./agent-harness/install.ps1
```

Restart Cursor.

## Machine-specific (not in universal docs)

| Topic | Windows | Mac |
|-------|---------|-----|
| Fast CLIs | `winget install BurntSushi.ripgrep sharkdp.fd` | `brew install ripgrep fd` |
| Shared Python | optional `config/harness.yaml` | same |

## Do not commit

| Path | Why |
|------|-----|
| `.scratch/` | Local plans, handoffs |
| `.agents/` | Vendor skill install target |
| `.env.local` | Secrets |
