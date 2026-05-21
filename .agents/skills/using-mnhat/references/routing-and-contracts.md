# Routing And Contracts

Open this only when the route is unclear or the handoff contract needs clarification.

## First-Skill Routing

| Request Type | First Skill |
| --- | --- |
| vague or new feature | `exploring` |
| clear scoped work needing a plan | `planning` |
| approved plan needing proof | `validating` |
| one approved bounded slice | `executing` |
| explicit delegation request | `swarming` |
| review request after implementation | `reviewing` |
| learnings capture | `compounding` |
| rough long-running objective | `goal-griller` |

## State Contract

Use `.mnhat` as the shared artifact root:

- `.mnhat/session/` for transient handoff only
- `.mnhat/exploring/<feature>/` for locked context
- `.mnhat/planning/<feature>/` for approach and shape artifacts
- `.mnhat/validating/<feature>/` for readiness reports
- `.mnhat/swarming/` for coordinated execution artifacts during active delegation
- `.mnhat/reviewing/<feature>/` for review outputs

Use `bd` for all durable task tracking. Use `bd remember` for durable project memory and lessons.

## Handoff Contract

Each skill should end with:

1. what became true
2. which artifact is now source of truth
3. what next skill should run, if any

Do not hand off to a skill that does not exist in this repo.
