---
status: accepted
date: 2026-10-02
---

# Reserve MCP for external systems and cap the session at six servers

**Decision.** Enable at most six MCP servers per session, use MCP only to reach external systems (GitHub, databases, browsers, APIs), and keep coding conventions in rules and skills. Applies to: `cursor-rules/mcp-routing.mdc`.

## Context

Each connected server spends context on tool definitions before any work starts, and MCP sprawl is one of the named failure modes the harness exists to fix. Conventions are static text that an agent can read from the repo, so routing them through a server buys nothing and costs tokens. A fixed cap forces a per-task choice instead of leaving every server on.

## Consequences

Sessions pick a profile up front, and adding a server to a task means disabling another. Convention changes ship as a rule or skill edit in git rather than a server change, which keeps them portable across the supported IDEs. Rejected alternative: serving coding conventions over MCP — rejected because that is the job of rules and skills.
