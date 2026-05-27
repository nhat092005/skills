# validation-report.md Template

Write this to `.mnhat/<YYYY-MM-DD>-<feature-slug>/validating/validation-report.md`.

```markdown
# Validation Report: <Feature>

## Reality Gate

- Mode fit: PASS | FAIL
- Repo fit: PASS | FAIL
- Assumptions: PASS | FAIL
- Smaller path: PASS | FAIL
- Proof surface: PASS | FAIL

## Feasibility Matrix

| Part / Assumption | Risk | Proof Required | Evidence | Result |
| --- | --- | --- | --- | --- |
| <item> | LOW | <proof> | <evidence> | PASS |

## Readiness

- Status: READY | READY WITH CONSTRAINTS | NOT READY - RUN SPIKE | NOT READY - RETURN TO PLANNING
- Integration readiness: PASS | FAIL
- Unresolved concerns: <none | list>

## Approval Gate

- Current work: <name>
- Approve execution for this current work only: yes | no
```
