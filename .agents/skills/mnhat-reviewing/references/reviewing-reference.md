# Reviewing Reference

Use after `mnhat-executing` or `mnhat-swarming` completes.

## Review Order

1. correctness and failure scenarios
2. architecture and boundary fit
3. security and data exposure
4. test coverage and regression safety
5. user-facing behavior and UAT

## Severity

- `P1`: security breach, data loss, breaking behavior, or release blocker
- `P2`: important reliability, architecture, performance, or test gap
- `P3`: cleanup, docs, or future debt

When uncertain, choose `P2`.

## Artifact Verification

For each promised artifact, verify:

- `EXISTS`: it exists
- `SUBSTANTIVE`: it is not stub, placeholder, TODO-only, or fake wiring
- `WIRED`: it is actually connected to the real path

All three pass = OK.

## UAT Prompt

```text
UAT Item <i>/<n> - Decision <D-id>:
"<deliverable>"
Can you confirm this works? [Pass / Fail / Skip]
```

Skip requires a reason. Fail creates a `P1` fix path.

Write reviewing artifacts inside `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/`.

Use:

- `references/review-report-template.md` for the canonical review report
- `references/requirements-check-template.md` for requirement-to-outcome mapping
- `references/uat-notes-template.md` when UAT detail needs a separate file
