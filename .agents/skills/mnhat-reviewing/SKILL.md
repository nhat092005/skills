---
name: mnhat-reviewing
description: Run the final quality gate after implementation. Use when current work is implemented and needs findings, artifact verification, UAT, and a clear handoff into compounding or follow-up fixes.
---

# MNHAT Reviewing

## Quick start

- Review the delivered work and fresh verification evidence.
- Write reviewing artifacts inside `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/`.
- Hand off to `mnhat-compounding` when the quality gate is satisfied.

## Workflows

1. Review correctness, boundaries, security, tests, and user-visible behavior.
2. Verify promised artifacts at EXISTS, SUBSTANTIVE, and WIRED.
3. Report findings with `P1`, `P2`, or `P3`.
4. Record UAT requirements and outcomes.
5. Hand off accepted work to `mnhat-compounding`.

## Outputs

- Canonical artifacts:
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/review-report.md`
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/requirements-check.md`
  - `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/uat-notes.md`
- Canonical template owners:
  - `references/review-report-template.md`
  - `references/requirements-check-template.md`
  - `references/uat-notes-template.md`

## State rules

- `review-report.md` is the primary artifact when `state.json.phase` is `reviewing`.
- `P1` findings block completion until acknowledged.
- Call `mnhat-implementation-record` when the review locks a meaningful accept/reject/defer decision.

## Further reading

- `references/reviewing-reference.md` - severity, artifact verification, and UAT rules
- `references/review-report-template.md` - canonical `review-report.md` form
- `references/requirements-check-template.md` - canonical `requirements-check.md` form
- `references/uat-notes-template.md` - optional `uat-notes.md` form
