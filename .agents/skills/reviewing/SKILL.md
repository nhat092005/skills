---
name: reviewing
description: Run the final quality gate after execution. Use when current work is implemented and needs findings, artifact verification, user-facing checks, and a clear handoff into follow-up work or compounding.
---

# Reviewing

Use after execution is complete and before calling the work finished.

Reviewing verifies that completed work is correct, safe, wired, and acceptable to the user. Default to local review. Bring in extra specialist reviewers only when the user explicitly asks for parallel review passes.

## Required Inputs

- locked context document
- planning artifacts that defined the approved work
- current git diff, branch range, or merged result
- test output and verification evidence
- any current-work `bd` items that were executed

## Operating Contract

1. Review the delivered work for correctness, architecture, security, tests, and user-facing behavior.
2. Verify promised artifacts at the EXISTS, SUBSTANTIVE, and WIRED levels.
3. Report findings with `P1`, `P2`, or `P3` severity.
4. Treat `P1` findings as a hard stop until the user acknowledges the gate.
5. Walk the user through any required UAT items from locked decisions.
6. Create or update `bd` follow-up items for real findings or accepted remaining work before handoff.

Load `references/reviewing-reference.md` for severity rules, review-report shape, artifact verification, and UAT flow.

## Hard Gates

- `P1` findings block completion until acknowledged by the user.
- Artifact verification is mandatory; closed tasks alone are not proof.
- UAT failures are never logged as passes.
- Do not invent follow-up work for vague concerns.
- Do not auto-dispatch reviewers unless the user explicitly asks for parallel review.
- Do not call the session complete until follow-up `bd` work is captured and downstream closeout finishes.

## Outputs

- `.mnhat/reviewing/<feature-slug>/review-report.md`
- required `bd` follow-up items for accepted findings or remaining work
- optional `.mnhat/reviewing/<feature-slug>/uat-notes.md`

## Handoff

If review is clean or findings are accepted and tracked, point the workflow to `compounding`.

```text
Review complete. Findings are documented under `.mnhat/reviewing/<feature>/`.
If the work is complete or intentionally paused, move to $compounding to capture durable lessons, file final `bd` memory, and finish session closeout.
```
