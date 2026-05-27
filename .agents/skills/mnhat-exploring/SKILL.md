---
name: mnhat-exploring
description: Capture locked decisions for ambiguous work before planning. Use when a feature, bug fix, or workflow request still needs scope, boundaries, and a canonical `context.md` before implementation planning.
---

# MNHAT Exploring

## Quick start

- Ask one question at a time.
- Lock only user-facing and scope-defining decisions.
- Write workstream artifacts under `.mnhat/<YYYY-MM-DD>-<feature-slug>/exploring/`.
- Stop when downstream planning can proceed without guesswork.

## Workflows

1. Classify scope as `Quick`, `Standard`, or `Deep`.
2. Pick only relevant probes from `references/gray-area-probes.md`.
3. Do a shallow scout of current repo reality.
4. Lock decisions with stable IDs such as `D1`, `D2`, `D3`.
5. Write `context.md` from `references/context-template.md`.
6. Write `open-questions.md` and `resolved-questions.md` when they have real content.
7. Hand off to `mnhat-planning` or `goal-griller`.

## Outputs

- Canonical artifacts:
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/exploring/context.md`
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/exploring/open-questions.md`
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/exploring/resolved-questions.md`
- Canonical template owners:
  - `references/context-template.md`
  - `references/open-questions-template.md`
  - `references/resolved-questions-template.md`

## State rules

- `context.md` is the primary artifact when `state.json.phase` is `exploring`.
- Do not mutate code, create execution tasks, or write planning artifacts here.
- If a meaningful decision is made that should survive resume, call `mnhat-implementation-record`.

## Further reading

- `references/context-template.md` - canonical `context.md` shape
- `references/open-questions-template.md` - canonical `open-questions.md` form
- `references/resolved-questions-template.md` - canonical `resolved-questions.md` form
- `references/gray-area-probes.md` - question bank for ambiguous requests
