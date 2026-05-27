---
name: mnhat-validating
description: Prove that planned current work is feasible before implementation. Use when planning artifacts exist and the next step needs repo-truth, evidence, and explicit approval instead of optimistic execution.
---

# MNHAT Validating

## Quick start

- Read approved planning artifacts.
- Run a reality gate against current repo truth.
- Write `.mnhat/<YYYY-MM-DD>-<feature-slug>/validating/validation-report.md`.
- Stop for execution approval.

## Workflows

1. Orient on approved context, plan, and current-work artifact.
2. Prove repo fit, feasibility, and verification readiness.
3. Require spikes when assumptions can invalidate the path.
4. Write the validation report.
5. Hand off to `mnhat-executing` or `mnhat-swarming` only after approval.

## Outputs

- Canonical artifact: `.mnhat/<YYYY-MM-DD>-<feature-slug>/validating/validation-report.md`
- Canonical template owner: `references/validation-report-template.md`

## State rules

- `validation-report.md` is the primary artifact when `state.json.phase` is `validating`.
- Missing approved work shape routes back to `mnhat-planning`.
- Call `mnhat-implementation-record` when validation changes the path, rejects the plan, or records a meaningful constraint.

## Further reading

- `references/validation-reference.md` - gates, matrix, and approval protocol
- `references/validation-report-template.md` - canonical `validation-report.md` form
