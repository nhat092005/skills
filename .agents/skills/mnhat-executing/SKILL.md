---
name: mnhat-executing
description: Implement one approved current-work item or parent-assigned slice. Use when planning or swarming has already chosen the scope and the next step is to make the change, verify it, and report precisely.
---

# MNHAT Executing

## Quick start

- Require exactly one approved current-work slice.
- Read the current planning and validation artifacts first.
- Make the change, verify it, and write `.mnhat/<YYYY-MM-DD>-<feature-slug>/executing/execution-report.md`.
- If a meaningful decision is made, call `mnhat-implementation-record`.

## Workflows

1. Read `AGENTS.md`, context, plan, and validation report.
2. Confirm one approved current-work item and bounded scope.
3. Implement without drifting into adjacent work.
4. Run the required verification.
5. Write `execution-report.md`.
6. Pause only through `.mnhat/state.json` with explicit resume data.

## Outputs

- Canonical artifact: `.mnhat/<YYYY-MM-DD>-<feature-slug>/executing/execution-report.md`
- Canonical template owner: `references/execution-report-template.md`

## State rules

- `execution-report.md` is the primary artifact when `state.json.phase` is `executing`.
- `artifact_paths[]` should usually include the execution report, the implementation record when present, and the immediate input artifact such as `current-story-pack.md` or `validation-report.md`.
- If blocked by a failure that needs root-cause work, hand off to `mnhat-debugging`.

## Further reading

- `references/worker-details.md` - result fields, pause rules, and scope checks
- `references/execution-report-template.md` - canonical `execution-report.md` form
