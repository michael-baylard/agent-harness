# Reference Catalog — Tools, Packages, and Patterns

> _Last updated: 2026-09-09_

Curated public sites, packages, and tools for agent harness work. **ROI tier** = return on attention for a typical harness builder (not benchmark scores).

| Tier | Meaning |
|------|---------|
| **S** | Adopt early; daily leverage or structural win |
| **A** | Strong fit for specific workflows; learn when you hit the problem |
| **B** | Situational; worth knowing, not default |

---

## Fast Ops — Rust CLIs

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **ripgrep** (`rg`) | [github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) | Default text search for agents and humans; respects `.gitignore`, fast on large trees | **S** |
| **fd** | [github.com/sharkdp/fd](https://github.com/sharkdp/fd) | Filename discovery without fragile `find` syntax; pairs with `rg` for locate-then-read | **S** |
| **ast-grep** | [ast-grep.github.io](https://ast-grep.github.io/) | Structural code search/replace; catches patterns regex misses | **A** |
| **sqz** | [github.com/aspect/sqz](https://github.com/aspect/sqz) | Compresses verbose tool output and dedups reads; lowers agent token burn | **A** |
| **difftastic** (`difft`) | [github.com/Wilfred/difftastic](https://github.com/Wilfred/difftastic) | Syntax-aware diffs; faster review of agent-generated patches | **A** |
| **sd** | [github.com/chmln/sed](https://github.com/chmln/sd) | Intuitive find-replace for scripted refactors; simpler mental model than `sed` | **B** |

**Pattern:** Expose these as MCP or shell tools with stable output — agents should grep the repo, not invent search scripts.

---

## Agent Process & Skills

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **skills.sh** | [skills.sh](https://skills.sh) | Registry + installer for portable agent skills; encodes spec→ticket→implement chains | **S** |
| **mattpocock/skills** | [github.com/mattpocock/skills](https://github.com/mattpocock/skills) | Reference implementation of grill / to-spec / to-tickets / implement / code-review | **S** |
| **Cursor docs** | [cursor.com/docs](https://cursor.com/docs) | Rules, skills, MCP, subagents — canonical harness surface for Cursor users | **S** |
| **Cursor Agent CLI** | [cursor.com/docs/cli](https://cursor.com/docs/cli) | Headless agent for CI, scripts, and control-plane adapters | **A** |
| **parallel-agents-skill** | [github.com/knods-io/parallel-agents-skill](https://github.com/knods-io/parallel-agents-skill) | Worktree-isolated workers + validator + human merge gate | **A** |
| **agent-swarm-skill** | [github.com/streeboga/agent-swarm-skill](https://github.com/streeboga/agent-swarm-skill) | tmux + worktree + verify pipeline for parallel Claude sessions | **B** |

---

## MCP & Documentation Access

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **Context7** | [context7.com](https://context7.com) | Up-to-date library/API docs injected into agent context; avoids stale training data | **S** |
| **GitHub MCP** | [github.com/github/github-mcp-server](https://github.com/github/github-mcp-server) | Issues, PRs, checks, repo ops without custom API wrappers | **S** |
| **Model Context Protocol spec** | [modelcontextprotocol.io](https://modelcontextprotocol.io) | Standard for tool/resource servers; pattern for any harness extensibility | **S** |
| **Neon MCP** (Postgres) | [neon.tech/docs/ai/neon-mcp-server](https://neon.tech/docs/ai/neon-mcp-server) | Schema-aware SQL from agents without hand-written migration scripts | **A** |
| **Exa MCP** | [exa.ai](https://exa.ai/) | Semantic web search + fetch when SERP volume or niche pages matter | **A** |
| **Tavily** | [tavily.com](https://tavily.com/) | Research-oriented extract/synthesize for page content | **B** |

**GitHub MCP pattern:** One authenticated server replaces dozens of brittle `gh` wrapper scripts; route read vs write by profile (enable ≤6 servers per session).

---

## Harness Control Planes

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **T3 Code** | [github.com/pingdotgg/t3code](https://github.com/pingdotgg/t3code) | Multi-provider agent shell: threads, diffs, terminals, checkpoints | **A** |
| **OpenCode** | [opencode.ai](https://opencode.ai/) | Provider-agnostic coding agent CLI; adapter target for control planes | **A** |
| **99 (Neovim)** | [github.com/ThePrimeagen/99](https://github.com/ThePrimeagen/99) | Editor-native semantic search + rules/files context injection | **A** |
| **Agent Client Protocol (ACP)** | [agentclientprotocol.com](https://agentclientprotocol.com/) | JSON-RPC stdio protocol for host↔agent sessions (Cursor, Zed ecosystem) | **B** |

---

## Language & Package Managers

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **uv** | [docs.astral.sh/uv](https://docs.astral.sh/uv/) | Fast Python env + lockfile + `uv run`; replaces pip/venv ceremony for agents | **S** |
| **pnpm** | [pnpm.io](https://pnpm.io/) | Strict, disk-efficient Node installs; monorepo-friendly for web harness targets | **S** |
| **mise** (asdf successor) | [mise.jdx.dev](https://mise.jdx.dev/) | Pin tool versions per repo; agents get reproducible CLIs | **A** |
| **Bun** | [bun.sh](https://bun.sh/) | Fast JS runtime + package manager; T3 Code server target | **B** |

---

## Runtimes & Frameworks (when agents touch product code)

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **Tokio** | [tokio.rs](https://tokio.rs/) | De-facto async Rust runtime; read before editing Rust services | **A** |
| **Effect** | [effect.website](https://effect.website/) | Typed errors, layers, schemas — used heavily in T3 Code server | **B** |
| **Next.js** | [nextjs.org/docs](https://nextjs.org/docs) | App Router + RSC; default for many agent-built web UIs | **A** |
| **Vercel AI SDK** | [sdk.vercel.ai](https://sdk.vercel.ai/) | Streaming, tool calls, provider adapters for in-app agents | **A** |
| **Pydantic v2** | [docs.pydantic.dev](https://docs.pydantic.dev/) | Validated config and tool I/O in Python pipelines | **A** |

---

## Testing & Verification

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **Playwright** | [playwright.dev](https://playwright.dev/) | Browser verification agents can't do by reading source alone | **S** |
| **Vitest** | [vitest.dev](https://vitest.dev/) | Fast unit/integration tests in TS monorepos | **A** |
| **pytest** | [docs.pytest.org](https://docs.pytest.org/) | Standard Python test runner for pipeline verification gates | **A** |
| **ast-grep (CI rules)** | [ast-grep.github.io/reference/cli/scan.html](https://ast-grep.github.io/reference/cli/scan.html) | Custom lint rules as code; enforce harness conventions in CI | **B** |

---

## Git & Parallelism

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **git worktree** | [git-scm.com/docs/git-worktree](https://git-scm.com/docs/git-worktree) | Isolation primitive for parallel agents on one clone | **S** |
| **Graphite / gh stack** | [graphite.dev](https://graphite.dev/) | Stacked PRs when agents ship small vertical slices | **B** |
| **Superset** | [superset.sh](https://superset.sh/) | Orchestrated worktrees + review UI for multi-agent workflows | **B** |

---

## Token & Context Optimization

| Tool | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **sqz MCP** | [github.com/aspect/sqz](https://github.com/aspect/sqz) | `sqz_read_file`, `sqz_grep`, compress — structured token diet | **A** |
| **Repomix / gitingest** | [repomix.com](https://repomix.com/) | Pack repo slices for one-shot context (use sparingly — prefer search) | **B** |
| **Embeddings + vector DB** | [pgvector](https://github.com/pgvector/pgvector) | Semantic codebase search at scale; higher setup cost | **B** |

---

## Learning Hubs

| Site | URL | One-line ROI | Tier |
|------|-----|--------------|------|
| **Agentic Coding Patterns** | [aipatternbook.com](https://aipatternbook.com/) | Named patterns (local reasoning, seams, verification) with agent angle | **S** |
| **CodeSloth blog** | [codesloth.blog](https://codesloth.blog/) | Practical Cursor + skills + verification writeups | **A** |
| **AI Hero (Matt Pocock)** | [aihero.dev](https://www.aihero.dev/) | Skill deep-dives and workflow essays | **A** |
| **Martin Fowler** | [martinfowler.com](https://martinfowler.com/) | Refactoring, technical debt, quality economics | **A** |

---

## Quick Adoption Path

1. **Day 1:** `rg` + `fd` + Cursor docs + skills.sh + Context7 + GitHub MCP.
2. **Week 1:** `uv` or `pnpm` lockfiles, git worktree parallel playbook, Playwright verification for UI.
3. **Month 1:** ast-grep rules, sqz for long sessions, control plane evaluation (T3 Code or editor-native 99).

Revisit tiers when your bottleneck shifts — token cost, merge conflicts, doc staleness, or review latency.
