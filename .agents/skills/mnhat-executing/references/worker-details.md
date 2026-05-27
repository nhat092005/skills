# Worker Details

Open this when `mnhat-executing` needs exact worker expectations or report fields.

## Required Inputs

The executor should know:

- current-work item or issue id
- scope boundary
- relevant context and planning paths
- verification commands or observable checks
- whether the work is part of a larger coordinated run

## Scope Check

Before editing, confirm:

- the item is approved current work
- acceptance criteria are concrete
- file scope is understandable
- locked decisions are not contradicted

Return `[NOOP]` if no safe item exists. Return `[BLOCKED]` if the scope is ambiguous.

## Verification Failure

Fix root cause and rerun the exact failing check. After two serious attempts, return `[BLOCKED]` with:

- current-work id
- command or check that failed
- brief failure summary
- smallest useful next decision

## Result Fields

- `[DONE]`: current work completed, verification passed
- `[BLOCKED]`: cannot continue safely
- `[PAUSED]`: safe pause with resume data written
- `[NOOP]`: assigned item is unavailable or unsafe

Minimum fields:

- current-work id or title
- write paths or intended write surface
- verification result
- status summary
- next action

## State Pause

When pausing coordinated work, update `.mnhat/state.json` with:

- current-work id
- write paths
- completed steps
- remaining steps
- verification state
- exact resume point

Write `.mnhat/<YYYY-MM-DD>-<feature-slug>/executing/execution-report.md` using `references/execution-report-template.md`.
