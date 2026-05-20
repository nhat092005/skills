# BD (Beads) Workflow

This project uses **bd (beads)** for ALL issue tracking.
Do NOT use markdown TODOs, task lists, or any other tracking method.

## Rules

- `bd prime` is the single source of truth for commands and workflow context
- Use `--json` flags for all programmatic output
- Never use `bd edit` — it opens an interactive editor that blocks the session
- Always use `--claim` to atomically acquire tasks (prevents race conditions with other agents)
- Never create MEMORY.md files — use `bd remember "insight"` instead

---

## Session Startup

At the start of every session, run in order:

```bash
bd prime              # Get current workflow context + command reference
bd ready --json       # See all unblocked tasks
```

Pick the highest-priority unblocked task, then claim it atomically:

```bash
bd update <id> --claim   # Sets assignee + in_progress atomically
bd show <id> --json      # Read full task details before starting
```

---

## During Work

### Creating issues when you discover new work

```bash
# Standard task
bd create "Fix login timeout" -t task -p 1 --json

# With description (use stdin for special characters)
echo 'Description with `backticks` and "quotes"' | bd create "Title" --description=- --json

# Link to parent task (discovered during work)
bd create "Found related bug" -t bug -p 1 \
  --deps discovered-from:<parent-id> --json
```

### Updating issues

```bash
bd update <id> --priority 0          # Escalate priority
bd update <id> --title "New title"
bd update <id> --description "new description"
bd update <id> --notes "additional context"
bd update <id> --acceptance "done when X passes"
```

### Managing dependencies

```bash
bd dep add <child-id> <blocker-id>   # child is blocked by blocker
bd dep tree <id>                     # Visualize dependency tree
bd dep cycles                        # Check for circular deps (must fix!)
```

### Tracking memory and insights

```bash
bd remember "always run tests before closing auth-related tasks"
bd remember "db migrations must be backward compatible"
```

---

## Priority Scale

| Value | Meaning |
|-------|---------|
| `0` | Critical — drop everything |
| `1` | High |
| `2` | Medium (default) |
| `3` | Low |
| `4` | Backlog |

## Issue Types

`task` · `bug` · `feature` · `epic` · `docs` · `question`

---

## Multi-Agent Guardrail

Other agents may be working in this repo simultaneously.

- If you see unexpected file changes you did not make: **do not stash, revert, or overwrite them**
- Treat them as your own changes and continue
- Use `bd ready` to pick only unblocked work — this prevents two agents from claiming the same task
- The `--claim` flag is atomic: only one agent can claim a task

---

## Landing the Plane (Session Completion)

**The session is NOT done until `git push` succeeds.**

Run ALL steps in order:

```bash
# 1. File issues for any remaining work
bd create "Follow-up: ..." -t task -p 2 --json

# 2. Run quality gates (only if code changed)
# → run your project's test/lint commands here

# 3. Close finished tasks
bd close <id> --reason "Completed" --json
bd close <id1> <id2> --reason "Done" --json   # close multiple at once

# 4. Pull + push (MANDATORY — do not stop here)
git pull --rebase
git push

# 5. Verify
git status   # must show "up to date with origin/main"

# 6. Clean up
git stash clear
git remote prune origin
```

After landing, provide:
- Summary of what was completed
- Issues filed for follow-up
- Recommended prompt for next session: `"Continue work on bd-X: [title]. [context]"`

---

## Quick Reference

```bash
bd prime                          # Workflow context (run first)
bd ready --json                   # Unblocked tasks
bd show <id> --json               # Task details
bd update <id> --claim            # Claim a task atomically
bd close <id> --reason "Done"     # Close a task
bd create "Title" -t task -p 1    # Create a task
bd remember "insight"             # Save persistent memory
bd list --status open --json      # All open issues
bd dep add <child> <blocker>      # Add dependency
bd doctor                         # Health check
```
