# Ticket run templates

Copy a skeleton below into the matching file under
`data-architect-knowledge-base/context/tickets/<KEY>/`.

Rules for every skeleton:

| Rule | Detail |
|---|---|
| Unknown value | Write `Unknown` |
| No person named | Write `Not on the ticket` |
| Keep headings | Do not rename or drop a heading; a later run looks for it |
| `## Notes` | Human-owned. Create it empty and never rewrite it |

---

## brief.md

```markdown
# <KEY> — <summary>

| Field | Value |
|---|---|
| Key | [<KEY>](https://cfacorp.atlassian.net/browse/<KEY>) |
| Type | <issue type> |
| Status | <status> |
| Assignee | <name or Not on the ticket> |
| Reporter | <name or Not on the ticket> |
| Jira updated | <YYYY-MM-DD> |

## Problem

<What is broken or missing, in two or three sentences.>

## Why it matters

<Who feels the pain and what it costs.>

## What done means

- [ ] <Acceptance criterion from the ticket.>
- [ ] <Acceptance criterion from the ticket.>

## Who decides

<Name and role, or Not on the ticket.>

## Who to ask

| Topic | Person | Source |
|---|---|---|
| <topic> | <name or Not on the ticket> | <reporter / commenter / linked issue> |

## Which repo

| Repo | Why it is in scope |
|---|---|
| `<repo>` | <reason from the ticket> |

## What is already in flight

| Item | State | Link |
|---|---|---|
| <linked issue or named pull request> | <state> | <url> |

## What can go wrong

| Risk | Signal | Response |
|---|---|---|
| <risk> | <how you would notice> | <what to do> |

## What must be said to whom

| Audience | Message | When |
|---|---|---|
| <audience> | <message> | <trigger> |

## Open questions

- <Question the ticket does not answer.>

## Out of scope

- <Thing this ticket will not do.>

## Notes

<!-- Human-owned. The skill never rewrites this section. -->
```

---

## plan.md

```markdown
# <KEY> — plan

## Steps

| # | Step | Files or area | Done when |
|---|---|---|---|
| 1 | <step> | `<path>` | <check> |
| 2 | <step> | `<path>` | <check> |

## Order and blockers

| Step | Blocked by |
|---|---|
| <#> | <blocker or None> |

## Communication plan

| Who hears | What they hear | When |
|---|---|---|
| <person or group> | <message> | <before start / at review / at done> |

## Notes

<!-- Human-owned. The skill never rewrites this section. -->
```

---

## verify.md

```markdown
# <KEY> — verify

Each check maps to one acceptance criterion in `brief.md`.

| # | Acceptance criterion | Check to run | Pass looks like | Result |
|---|---|---|---|---|
| 1 | <criterion> | `<command or manual step>` | <expected output> | <pending / pass / fail> |

## Out-of-scope failures

<Failures this ticket does not own. Name them so they do not block the ship.>

## Notes

<!-- Human-owned. The skill never rewrites this section. -->
```

---

## log.md

Append-only. Newest entry goes directly under the heading.

```markdown
# <KEY> — log

## <YYYY-MM-DD> — <status>

- **What changed:** <one or two sentences>
- **Next action:** <next step, and who owns it>
```

---

## INDEX.md

Lives at `context/tickets/INDEX.md`. One row per ticket folder.

```markdown
# Open tickets

Updated by the `ticket-run` skill. One row per folder in this directory.

| Key | Summary | Status | Updated | Next action | Brief |
|---|---|---|---|---|---|
| [<KEY>](https://cfacorp.atlassian.net/browse/<KEY>) | <summary> | <status> | <YYYY-MM-DD> | <next action> | [brief](<KEY>/brief.md) |
```
