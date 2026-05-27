---
name: mnhat-swarming
description: Coordinate explicit parallel implementation for approved current work. Use when the user wants delegation or parallel workers and the work can be partitioned into bounded slices with clear ownership and verification.
---

# MNHAT Swarming

## Quick start

- Require explicit delegation approval.
- Split only approved current work into independent slices.
- Track the run in `.mnhat/<YYYY-MM-DD>-<feature-slug>/swarming/dispatch-plan.md`.
- Pause through `.mnhat/state.json` with `mode: "swarm"`.

## Workflows

1. Confirm approved current work and explicit delegation.
2. Partition into non-overlapping slices with bounded ownership.
3. Dispatch workers that use `mnhat-executing`.
4. Tend statuses, blockers, and verification in `dispatch-plan.md`.
5. Hand off the merged result to `mnhat-reviewing`.

## Outputs

- Canonical artifact: `.mnhat/<YYYY-MM-DD>-<feature-slug>/swarming/dispatch-plan.md`
- Canonical template owner: `references/dispatch-plan-template.md`

## State rules

- `dispatch-plan.md` is the primary artifact when `state.json.phase` is `swarming`.
- `state.json.mode` must be `swarm` only while this phase is active.
- Route single-slice work back to `mnhat-executing` instead of forcing delegation.

## Further reading

- `references/swarming-reference.md` - slice rules, worker prompt, and result formats
- `references/dispatch-plan-template.md` - canonical `dispatch-plan.md` form
