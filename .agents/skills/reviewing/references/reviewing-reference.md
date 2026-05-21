# Reviewing Reference

Use after execution completes.

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

## Review Report Shape

Write `.mnhat/reviewing/<feature-slug>/review-report.md` with:

```markdown
# Review Report: <Feature>

## Findings

### P1 | P2 | P3 - <title>
- Evidence: <file/line or command>
- Failure scenario: <realistic outcome>
- Smallest fix: <credible next step>

## Artifact Verification

- Artifact: <path or deliverable>
- EXISTS: PASS | FAIL
- SUBSTANTIVE: PASS | FAIL
- WIRED: PASS | FAIL
- Notes: <why>

## UAT

- Decision: <D-id>
- Check: <what user should confirm>
- Result: Pass | Fail | Skip
- Notes: <why>
```

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
