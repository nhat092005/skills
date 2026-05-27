---
name: mnhat-debugging
description: Diagnose blocked work and failures with evidence-first debugging. Use when implementation, verification, or integration work hits a blocker that needs reproducible root-cause analysis and a canonical `debug-report.md`.
---

# MNHAT Debugging

## Quick start

- Classify the failure.
- Reproduce the exact issue.
- Write the root cause sentence before fixing.
- Write `.mnhat/<YYYY-MM-DD>-<feature-slug>/debugging/debug-report.md`.
- Call `mnhat-implementation-record` when the debugging pass makes or rejects a meaningful change.

## Workflows

1. Triage the failure and state the type.
2. Reproduce the issue with exact evidence.
3. Diagnose until the root cause sentence is concrete.
4. Fix only if the path is safe and bounded.
5. Verify with the original failing check.
6. Write `debug-report.md` and return `[DONE]` or `[BLOCKED]`.

## Outputs

- Canonical artifact: `.mnhat/<YYYY-MM-DD>-<feature-slug>/debugging/debug-report.md`
- Canonical template owner: `references/debug-report-template.md`

## State rules

- `debug-report.md` is the primary artifact when `state.json.phase` is `debugging`.
- Use active `state.json`, slice ownership, and phase artifacts as source of truth instead of inventing a second coordination channel.
- Hand back to `mnhat-executing`, `mnhat-swarming`, or `mnhat-reviewing` once the blocker outcome is explicit.

## Further reading

- `references/debugging-protocol.md` - full evidence-first debugging loop
- `references/debug-report-template.md` - canonical `debug-report.md` form
