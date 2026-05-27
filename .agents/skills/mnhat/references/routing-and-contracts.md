# Routing And Contracts

Open this only when the route is unclear or the runtime state contract needs clarification.

## First-Skill Routing

| Request Type | First Skill |
| --- | --- |
| vague or new feature | `mnhat-exploring` |
| clear scoped work needing a plan | `mnhat-planning` |
| approved plan needing proof | `mnhat-validating` |
| one approved bounded slice | `mnhat-executing` |
| explicit delegation request | `mnhat-swarming` |
| blocked implementation or failing verification | `mnhat-debugging` |
| review request after implementation | `mnhat-reviewing` |
| learnings capture | `mnhat-compounding` |
| rough long-running objective | `goal-griller` |

## State Contract

Use `.mnhat` as the shared artifact root:

- `.mnhat/state.json` for the only current workflow state snapshot
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/implementation-record.md` for meaningful implementation decisions
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/exploring/` for locked context and questions
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/` for approach, shape, risk, and verification artifacts
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/validating/` for readiness reports
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/executing/` for execution reports
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/swarming/` for coordinated execution artifacts during active delegation
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/debugging/` for debugging reports
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/` for review outputs
- `.mnhat/<YYYY-MM-DD>-<feature-slug>/compounding/` for closeout and lessons

Use `bd` for all durable task tracking. Use `bd remember` for durable project memory and lessons.

All runtime artifact filenames are lowercase. Use `context.md`, never `CONTEXT.md`. Do not use any `HANDOFF.json` path.

## State Snapshot Contract

Each skill should end with:

1. what became true
2. which artifact is now source of truth
3. what next skill should run, if any

Do not route directly to `mnhat-implementation-record`. Phase skills call it internally when a meaningful decision must be recorded.
