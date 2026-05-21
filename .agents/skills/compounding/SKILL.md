---
name: compounding
description: Capture durable lessons from completed or intentionally abandoned work. Use when a review is complete, a feature is merged, or a workstream is being closed and reusable patterns, decisions, and failures should be written down for future sessions.
---

# Compounding

Use after meaningful work is complete or intentionally abandoned with clear lessons.

Compounding turns concrete evidence from finished work into reusable project memory and closes the loop before the session ends. Durable lessons belong in `bd remember`, and remaining work belongs in `bd`.

## Required Inputs

- relevant handoff notes in `.mnhat/`
- `bd` issue history or `.beads/` evidence
- review findings, debugging notes, or test output
- recent git diff and commit history
- design docs or plans touched by the work

If artifacts are incomplete, use the best available local evidence. Do not fabricate learnings.

## Workflow

1. Gather evidence and reconstruct what actually happened.
2. Analyze three lenses: reusable patterns, meaningful decisions, and failures or false assumptions.
3. Record durable lessons with `bd remember` in concise, reusable language tied to the real evidence.
4. Create or update follow-up `bd` items for anything still open, deferred, or intentionally abandoned.
5. If the session is ending, finish repo closeout: required quality gates, `git pull --rebase`, `git push`, then `git status`.

Load `references/compounding-reference.md` for capture criteria, `bd remember` content shape, and closeout order.

## Rules

- Do not run compounding for trivial work.
- Do not force subagents; analyze locally unless the user explicitly asks for delegation.
- Do not write generic `bd remember` notes. Each entry needs a concrete situation, root cause, and future rule.
- Do not invent evidence or backfill missing details from memory.
- Do not call the session complete until `git push` succeeds and `git status` confirms the repo is up to date.

## Handoff

```text
Compounding complete.
- Durable lessons captured with `bd remember`
- Follow-up work filed or updated in `bd`
- Session closeout finished, or explicit blocker reported
```

## Reference Files

| File                                  | When to Load                    |
| ------------------------------------- | ------------------------------- |
| `references/compounding-reference.md` | Protocol and closeout template  |
