# Cursor marketplace submit checklist

> _Last updated: 2026-09-09_

## Pre-submit

- [x] OG image live at `https://klarix.ai/og-image.png`
- [x] README lists 14 IDE slugs + `install.ps1 -Ide`
- [x] Link to `https://klarix.ai/harness/ides`
- [x] Platform hub: `https://klarix.ai/harness/platforms` (23 skills)
- [x] CLI/local hub: `https://klarix.ai/harness/local-models`
- [x] No em dashes in listing copy
- [x] MIT license visible in repo root
- [x] Plugin manifest: `.cursor-plugin/marketplace.json` + `plugins/agent-harness-core/.cursor-plugin/plugin.json`

## Listing copy (draft)

**Title:** Agent Harness — Multi-IDE AI Coding Agent OS

**Short:** Phase protocol, ROI-ranked skills (23 platform packs), MCP profiles, CLI + Ollama local routing, and ship gates for Cursor, Codex, Claude Code, Antigravity, Amazon Q, and 9 more IDEs.

**Keywords:** agent harness, cursor rules, AGENTS.md, MCP workflow, multi-IDE, ollama, codex cli, platform skills

**Long:** Free MIT core with HARNESS.md phase protocol, TOOLS-ROI catalog, model router, and 23 platform skills (Terraform, Next.js, dbt, Ollama, Agent CLI). Pro at klarix.ai/harness adds RAG and private stack depth.

## Assets

| Asset | Path |
|-------|------|
| Logo | klarix `web/public/logo.png` |
| OG | klarix `web/public/og-image.png` |
| Demo repo | https://github.com/michael-baylard/agent-harness |
| IDE matrix | https://klarix.ai/harness/ides |
| Platforms | https://klarix.ai/harness/platforms |
| Local/CLI | https://klarix.ai/harness/local-models |

## Post-submit

- [ ] Cross-link from `/mcp` and `/harness` (klarix) — partial via harness page
- [ ] HN / Reddit post with OG preview
- [ ] Track installs via GitHub clone stats + Pro checkout

## Submit steps

1. Open Cursor → Settings → Plugins / Marketplace (when publisher flow is open)
2. Upload or link `michael-baylard/agent-harness` with `.cursor-plugin/marketplace.json`
3. Paste listing copy above; attach OG URL
4. Verify `install.ps1 -Ide cursor` from README works on clean clone

## Blockers

None technical — manual submit through Cursor marketplace UI when publisher access is granted.
