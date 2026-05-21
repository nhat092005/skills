---
name: executing
description: Execute one approved current-work item or parent-assigned slice. Use when planning or swarming has already chosen the scope and the next step is to implement, verify, and report without drifting into adjacent work.
---

# Executing

Use for one bounded execution slice.

Executing is the disciplined worker loop for approved current work. It may run as a normal session or as a delegated worker, but it always handles exactly one scoped item at a time.

## Hard Gates

- Require one explicit current-work item, issue, or parent-assigned slice before starting.
- Require the slice to map to exactly one active `bd` item before execution starts.
- Read the relevant context and planning artifacts before editing.
- Do not choose new work, expand scope, or silently absorb adjacent tasks.
- Verify the claimed outcome before reporting done.
- If blocked, return a concise blocker report instead of improvising around it.

## Workflow

1. **Initialize**
   - Read `AGENTS.md`.
   - Read the approved context and planning artifacts for the current slice.
   - If invoked by `swarming`, treat the parent-assigned scope as source of truth.

2. **Confirm Scope**
   - Require exactly one approved item.
   - If the scope is ambiguous, missing, not tracked in `bd`, or conflicts with locked decisions, stop and report `[BLOCKED]`.

3. **Implement**
   - Read before editing.
   - Match existing patterns and locked decisions.
   - Keep changes inside the assigned scope and file boundary.

4. **Verify**
   - Run the current slice's verification exactly.
   - Fix root causes and rerun.
   - After two serious failed attempts, stop and report the failure evidence.

5. **Close And Report**
   - Update the approved `bd` work item only after verification passes.
   - Close or update that one `bd` item only. Do not quietly touch adjacent work.
   - Return one final status: `[DONE]`, `[BLOCKED]`, `[HANDOFF]`, or `[NOOP]`.

## Compaction

If context gets tight before a safe finish, write `.mnhat/session/HANDOFF.json` for a solo run or `.mnhat/swarming/HANDOFF.json` for a coordinated run. Include the `bd` item, files touched, verification state, and resume point before returning `[HANDOFF]`.

## Red Flags

- choosing your own work when scope should be assigned
- handling multiple items in one run
- editing outside the approved slice
- claiming done without fresh verification
- waiting silently instead of returning a status

Load `references/worker-details.md` only when you need the exact result fields or worker-report shape.
