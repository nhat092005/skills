---
name: planning
description: Turn locked context into the smallest believable execution plan. Use when scope is clarified enough for planning, but the work still needs a concrete shape, proof strategy, and approval boundary before implementation.
---

# Planning

Use when the request is understood well enough to plan, but not yet safe to execute.

Planning turns locked context into the smallest believable path to implementation. Write planning artifacts under `.mnhat/planning/<feature-slug>/` and keep the workflow lighter than the risk profile allows.

## Hard Gates

- Treat the context document as source of truth.
- Read relevant `bd` issue context and `bd remember` notes before discovery when they are relevant.
- Plan from current repo reality, not from assumed architecture.
- Choose the smallest work shape that honestly protects the work.
- Stop after the work shape until the user approves it.
- Do not create speculative future-work `bd` issues during planning.
- Do not start implementation while planning.

## Shape

`Mode -> Shape -> Current Work -> bd?`

Mode picks the lightest workflow that still manages risk:

- `direct_task`: obvious local change
- `spike`: one assumption decides the path
- `small_change`: bounded low-risk work
- `standard_feature`: ordered capability work
- `high_risk_feature`: data, security, external-contract, or broad-blast work

Load `references/planning-reference.md` for quality rules and artifact templates.

## Flow

1. **Bootstrap**
   - Read the locked context document, usually `.mnhat/exploring/<feature-slug>/CONTEXT.md`.
   - Read relevant `bd` context, `bd remember` notes, and repo conventions.

2. **Discovery**
   - Map repo reality, patterns, constraints, integration points, and unknowns.
   - Use the strongest available repo truth: code, tests, docs, contracts, and local runtime signals.

3. **Mode Gate**
   - Choose `direct_task`, `spike`, `small_change`, `standard_feature`, or `high_risk_feature`.
   - Record why smaller modes are insufficient when you choose a heavier mode.

4. **Synthesis**
   - Write `.mnhat/planning/<feature-slug>/approach.md` with path, risks, proof needs, likely files, and validating questions.

5. **Shape**
   - Write the smallest suitable shape artifact:
     - `.mnhat/planning/<feature-slug>/work-shape.md`
     - `.mnhat/planning/<feature-slug>/phase-plan.md`
     - `.mnhat/planning/<feature-slug>/epic-map.md`
   - Present the shape for approval and stop.

6. **Prep After Approval**
   - Prepare only the current work artifact:
     - `.mnhat/planning/<feature-slug>/current-story-pack.md`
     - or `.mnhat/planning/<feature-slug>/phase-contract.md`
   - If current work is not already tracked, create the `bd` item only for approved, current work.

7. **State And Handoff**
   - Tell the user:
     ```text
     Planning complete. Artifacts written under `.mnhat/planning/<feature>/`.
     Approve the work shape before execution prep. Approved current work must be tracked in `bd` before execution starts.
     ```

## Red Flags

- skipping the context document or learnings
- skipping the mode gate
- defaulting to phases when a lighter shape is enough
- creating future-work tasks before current work is approved
- vague proof, unclear boundaries, or risky assumptions without a spike
- turning planning into implementation
