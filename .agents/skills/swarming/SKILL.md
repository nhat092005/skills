---
name: swarming
description: Coordinate explicit parallel execution for approved current work. Use when the user wants delegation or parallel workers and the work can be partitioned into bounded slices with clear ownership and verification.
---

# Swarming

Use only when delegation is both requested and structurally safe.

Swarming coordinates bounded workers for approved current work. The orchestrator tends scope, ownership, status, and handoff. It does not quietly turn ordinary execution into parallel agent work.

## Hard Gates

- Require explicit user approval for delegation or parallel execution.
- Require approved current work from planning and validation.
- Partition work into bounded slices with non-overlapping ownership.
- Do not spawn workers for vague, coupled, or still-changing scope.
- If safe parallelization is not real, route back to `executing` instead.

## Workflow

1. **Confirm Readiness**
   - Read the current planning and validation artifacts.
   - Confirm the user actually wants delegation.

2. **Partition**
   - Split current work into independent slices.
   - Assign each slice a clear file or responsibility boundary and verification target.

3. **Dispatch**
   - Launch only the workers needed for the current slices.
   - Each worker must load `executing` and handle exactly one assigned slice.

4. **Tend**
   - Track worker id, slice, status, blockers, and verification targets in `.mnhat/swarming/dispatch-plan.md`.
   - Resolve scope conflicts at the orchestrator level, not by telling workers to be careful.

5. **Close Or Pause**
   - When all slices finish, summarize outcomes and remaining blockers.
   - If pausing, write `.mnhat/swarming/HANDOFF.json` with active slices and resume steps.

Load `references/swarming-reference.md` for slice rules, worker prompt shape, and result formats.

## Completion Signal

Swarming is complete when:

- all approved current slices are done and verified, or
- blockers are explicit enough to hand back to planning, validation, or the user

Then hand off to `reviewing` for final quality gates.
