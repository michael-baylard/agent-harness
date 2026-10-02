---
status: accepted
date: 2026-10-02
applies_to:
  - cursor-rules/mcp-routing.mdc
---

# Reserve MCP for external systems

MUST: Use MCP only to reach an external system such as GitHub, a database, a browser, or an API.
MUST: Enable at most six MCP servers in a session.
MUST NOT: Serve coding conventions over MCP. Those live in rules and skills.

Rejected: an MCP server whose only job is repo conventions.

Context: Each connected server spends context before any work starts. Adding a server means turning one off.
