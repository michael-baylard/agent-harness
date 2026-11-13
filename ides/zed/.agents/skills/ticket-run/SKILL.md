---
name: ticket-run
description: Builds a run folder (brief, plan, verify, log) for a Jira ticket and sweeps open tickets assigned to the current user. Use when the user says ticket-run, log this ticket, sweep my tickets, or new Jira ticket, when the user names an issue key such as DTTIC-1629, or when a new Jira ticket shows up in a session.
last_updated: 2026-11-05
---

# Ticket run

One Jira ticket gets one folder. That folder holds what the work is, how to do it, how to prove it is done, and what happened. A later chat reads those four files instead of an old transcript.

## Output root (hard rule)

```
/Users/michael.baylard/Developer/data-architect-knowledge-base/context/tickets/
```

| Rule | Detail |
|---|---|
| Write ticket files here only | One folder per issue key, plus `INDEX.md` at the root |
| Never write ticket bodies into | `agent-harness/`, `cfa/`, `cfa-github/` |
| Skill source of truth | `agent-harness/cursor-skills/ticket-run/` |

The skill lives in `agent-harness`. Chick-fil-A ticket facts do not.

## Jira

| Fact | Value |
|---|---|
| Site | https://cfacorp.atlassian.net |
| Cloud id | `cfacorp.atlassian.net` |
| Usual project | `DTTIC` |

Do not assume every ticket is `DTTIC`. Use the key the user gives you.

**Read only.** Do not transition, edit, or comment on a Jira issue.

## Mode 1 — Sweep

Use this mode when the user gives no key ("sweep my tickets").

JQL:

```
assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC
```

For each issue returned:

| Folder state | Action |
|---|---|
| `<KEY>/` missing | Create all four files from `templates.md`, then add a row to `INDEX.md` |
| `<KEY>/` exists, Jira status, assignee, or updated time changed | Append one entry to `log.md` and refresh that row in `INDEX.md` |
| `<KEY>/` exists, nothing changed | Do nothing |

Never overwrite `brief.md`, `plan.md`, or `verify.md` on a sweep.

## Mode 2 — One ticket

Use this mode when the user names a key or pastes a Jira URL.

1. Read the issue with `getJiraIssue` using `view: evidence`.
2. Read comments with `listJiraIssueComments`.
3. Read a linked pull request **only** when the ticket or a comment names it.

| Run | Action |
|---|---|
| First run | Write all four files from the `templates.md` skeletons |
| Later run | Append one entry to `log.md` |

On a later run, refresh a section of `brief.md`, `plan.md`, or `verify.md` only when the Jira text behind that section changed. Leave every other section alone. Keep the `## Notes` section exactly as the human left it.

## The four files

Copy the skeletons from [`templates.md`](templates.md) and fill them. Do not rewrite the skeletons from memory.

| File | Holds |
|---|---|
| `brief.md` | Problem, why it matters, what done means, who decides, who to ask, which repo, what is already in flight, what can go wrong, what must be said to whom, open questions, out of scope |
| `plan.md` | Implementation steps and a communication plan — who hears what, and when |
| `verify.md` | Checks that prove the ticket is done, each tied to an acceptance criterion |
| `log.md` | Append-only history. Newest entry on top. Date, status, what changed, next action |

`INDEX.md` at the tickets root is one table: key, summary, status, updated, next action, link to the brief.

## People

| Source | Allowed |
|---|---|
| Ticket reporter, assignee, commenters, people on linked issues | Yes |
| `data-architect-knowledge-base/context/catchup/` | Only when a name there is already tied to this ticket |
| Anyone else | No |

If nobody is named for a role, write `Not on the ticket`. Never invent a person. Do not add a pod member who is not on the ticket or in that catch-up note.

## Writing style

Grade 8–9 reading level. Short active sentences. Use a table when there are two or more facts. Keep keys, paths, and repo names in backticks.

## Do not

- Write ticket facts into `agent-harness/`, `cfa/`, or `cfa-github/`
- Overwrite `brief.md`, `plan.md`, or `verify.md` during a sweep
- Edit, transition, or comment on a Jira issue
- Guess a contact, a repo, or an acceptance criterion that the ticket does not state
