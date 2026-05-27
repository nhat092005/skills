---
name: mnhat-compounding
description: Capture durable lessons and close out a finished or intentionally abandoned workstream. Use when review is complete and the session needs a canonical compounding report plus durable follow-up memory.
---

# MNHAT Compounding

## Quick start

- Gather evidence from the active `.mnhat/` artifacts, `bd`, and recent changes.
- Write compounding artifacts inside `.mnhat/<YYYY-MM-DD>-<feature-slug>/compounding/`.
- Capture durable lessons with `bd remember`.
- File real follow-up work in `bd`.

## Workflows

1. Gather evidence from the finished workstream.
2. Separate patterns, decisions, and failures.
3. Write the compounding report.
4. Capture durable lessons with `bd remember`.
5. Create or update real follow-up `bd` work.

## Outputs

- Canonical artifacts:
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/compounding/compounding-report.md`
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/compounding/memory-candidates.md`
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/compounding/follow-up-work.md`
- Canonical template owners:
  - `references/compounding-report-template.md`
  - `references/memory-candidates-template.md`
  - `references/follow-up-work-template.md`

## State rules

- `compounding-report.md` is the primary artifact when `state.json.phase` is `compounding`.
- Do not fabricate lessons when artifacts are missing; use only current evidence.
- Call `mnhat-implementation-record` when closeout locks a meaningful decision or abandonment path.

## Further reading

- `references/compounding-reference.md` - capture rules and `bd remember` protocol
- `references/compounding-report-template.md` - canonical `compounding-report.md` form
- `references/memory-candidates-template.md` - canonical `memory-candidates.md` form
- `references/follow-up-work-template.md` - canonical `follow-up-work.md` form
