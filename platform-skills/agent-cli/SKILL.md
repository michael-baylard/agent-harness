---
name: agent-cli
description: Headless agent CLIs — Cursor Agent CLI, OpenAI Codex CLI, Claude Code, Gemini CLI. Use for CI scripts, parallel workers, and terminal-first harness loops.
last_updated: 2026-09-09
---

# Agent CLI harness

## Official docs

| CLI | URL |
|-----|-----|
| Cursor Agent CLI | https://cursor.com/docs/cli |
| OpenAI Codex CLI | https://developers.openai.com/codex |
| Claude Code | https://docs.anthropic.com/en/docs/claude-code |
| Gemini CLI | https://github.com/google-gemini/gemini-cli |

## Agent rules

1. **Same harness, different runtime** — `AGENTS.md`, skills, and MCP profiles apply; only the host binary changes.
2. **Install per IDE** — `install.ps1 -Ide codex|claude-code|gemini-cli|cursor` from agent-harness repo.
3. **Parallel workers** — prefer git worktrees + one CLI session per ticket (`/parallel-work`), not one 200k context.
4. **Non-interactive** — pipe prompts via stdin or `-p` flags; capture exit codes for CI ship gates.
5. **Local model routing** — CLI + Ollama/vLLM OpenAI base URL for cheap fan-out; cloud for merge-ready diffs.

## Codex-specific

- Native subagents in `.codex/agents/` (synced from harness `cursor-agents/`)
- MCP via Codex config + `mcp-profiles/*.yaml`

## Pairs with

- `ollama` / `vllm` — local backend
- `github-actions` — run CLI in CI with secrets from GitHub Actions
- `playwright` — post-CLI browser verify

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| CLI in auto-compact marathon | `/session-handoff` + fresh session |
| YOLO `--dangerously-skip-permissions` in CI | Scoped allowlist + human promote |
| Different rules per CLI without install.ps1 | One harness repo, IDE adapters |
