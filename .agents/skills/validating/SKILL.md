---
name: validating
description: Prove that the planned current work is feasible before execution. Use when planning artifacts exist and the next step needs repo-truth, evidence, and explicit approval instead of optimistic implementation.
---

# Validating

Use between planning and execution.

Validating is the hard gate that rejects believable-sounding plans unless repo reality, feasibility, and current-work readiness are all evidenced.

## Required Inputs

- locked context document
- planning artifacts under `.mnhat/planning/<feature-slug>/`
- approved work shape
- current-work artifact when the mode requires it
- the current `bd` item for the approved slice, if tracking already exists

If required planning inputs are missing, route back to `planning`. If the work shape has not been approved, stop immediately.

## Operating Contract

1. Orient on the approved work shape and current planning artifacts.
2. Run a reality gate against current repo truth.
3. Build a feasibility matrix from concrete evidence.
4. Require spike or probe work for assumptions that can invalidate the path.
5. Check integration readiness and current-work readiness.
6. Ask the user to approve execution for this current work only.

Load `references/validation-reference.md` for the detailed checklist, report shape, spike rules, and approval gate.

## Non-Negotiable Gates

- No source-editing execution before explicit user approval.
- Plausibility language without evidence is not READY.
- A failed reality gate or failed decisive spike returns the workflow to `planning`.
- Approval is for current work only, not future work.
- Do not treat missing verification as a minor detail.
- If the approved slice is not yet represented in `bd`, call that out explicitly before handing off to execution.

## Output

Write `.mnhat/validating/<feature-slug>/validation-report.md`.

Then hand off:

```text
Validation complete. Current work is ready for approval.
If approved, ensure the current slice is tracked in `bd`, then proceed with $executing or $swarming depending on whether delegation is needed.
```
