---
name: mnhat-planning
description: Turn locked context into the smallest believable execution plan. Use when scope is clarified enough for planning, but the work still needs approach, work-shape, and current-story artifacts before implementation.
---

# MNHAT Planning

## Quick start

- Read the locked `context.md`.
- Discover current repo reality.
- Write planning artifacts inside the active workstream tree.
- Stop before implementation.

## Workflows

1. Read the locked context and any relevant `bd` evidence.
2. Map repo reality, patterns, constraints, and unknowns.
3. Pick the lightest honest mode.
4. Write `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/approach.md`.
5. Write `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/work-shape.md` and stop for approval.
6. After approval, write `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/current-story-pack.md`.
7. Write companion planning files when they have real content.

## Outputs

- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/approach.md`
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/alternatives.md`
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/risk-map.md`
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/work-shape.md`
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/current-story-pack.md`
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/verification-plan.md`

Canonical template owners:

- `references/approach-template.md`
- `references/alternatives-template.md`
- `references/risk-map-template.md`
- `references/work-shape-template.md`
- `references/current-story-pack-template.md`
- `references/verification-plan-template.md`

## State rules

- `current-story-pack.md` is the default primary artifact when `state.json.phase` is `planning`.
- Do not create speculative future-work `bd` items during planning.
- Call `mnhat-implementation-record` when planning locks a meaningful implementation decision.

## Further reading

- `references/planning-reference.md` - quality rules and mode guidance
- `references/approach-template.md` - canonical `approach.md` form
- `references/alternatives-template.md` - canonical `alternatives.md` form
- `references/risk-map-template.md` - canonical `risk-map.md` form
- `references/work-shape-template.md` - canonical `work-shape.md` form
- `references/current-story-pack-template.md` - canonical `current-story-pack.md` form
- `references/verification-plan-template.md` - canonical `verification-plan.md` form
