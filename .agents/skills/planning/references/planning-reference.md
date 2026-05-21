# Planning Reference

Use when `$planning` needs quality rules or artifact schemas.

## Quality Rules

- Choose one mode first: `direct_task`, `spike`, `small_change`, `standard_feature`, or `high_risk_feature`.
- Use the lightest workflow that honestly protects the work.
- Use phases only for observable milestones. Use an epic map only when capability or risk areas make the work clearer.
- `high_risk_feature` should carry explicit proof needs before execution.
- Current work must be testable, bounded, and believable in one execution pass.
- `bd` issues are for approved current work, not speculative future planning.

Trace:

```text
mode -> shape -> current work -> bd?
```

## Mode Gate

| Mode | Use When | Shape |
| --- | --- | --- |
| `direct_task` | obvious local change | short approach + direct handoff |
| `spike` | one assumption decides path | yes/no question + proof |
| `small_change` | <=3 files, LOW risk, no API/data-model shift | one work shape |
| `standard_feature` | ordered user or system capability | work shape or phase plan |
| `high_risk_feature` | external, security, data, or broad-blast work | phase plan or epic map + proof needs |

Above `small_change`, record why smaller modes are insufficient.

## Discovery And Approach

`approach.md` should capture only facts needed to support the plan:

- repo reality: entry points, affected areas, constraints
- recommended path and rejected alternatives
- risk map: component, LOW/MEDIUM/HIGH, reason, proof needed
- likely file boundaries and validating questions

## Shape Artifacts

For direct, spike, or small work:

```markdown
# Work Shape: <Feature>
Mode: `<mode>`
Why this mode: <why smaller or larger workflow is unnecessary>
Current work: <outcome or yes/no spike question>
Proof: `<command>` or observable check
Out of scope: <not solved>
Approval: approve before execution prep or bd creation.
```

For milestone-shaped work:

```markdown
# Phase Plan: <Feature>
Mode: `standard_feature` | `high_risk_feature`
Feature summary: <2-4 sentences>
Phase overview: Phase | What Changes | Why Now | Demo | Unlocks
Order check: first phase is obvious; later phases build on it; no technical buckets.
Approval summary: current phase, picture after it, deferred work.
```

For capability or risk-shaped work:

```markdown
# Epic Map: <Feature>
Mode: `standard_feature` | `high_risk_feature`
Feature outcome: <what is true when all epics finish>
Reality basis: <repo facts, stack constraints, external limits>
Epics: Epic | Capability/Risk Area | Why It Exists | Proof Needed
Current work to prepare: <story or slice, why now, testable exit>
```

## Current Work Prep

For current-slice work:

```markdown
# Current Story Pack: <Slice>
Entry state: <current repo truth>
Exit state: <what must be true after execution>
Files likely touched: <bounded list>
Feasibility assumptions: <assumption | risk | proof needed>
Verification: <commands/checks>
Out of scope: <not solved>
bd mapping: <created only after approval>
```

For phase-shaped work:

```markdown
# Phase Contract: <Phase>
Entry state: <observable truth>
Exit state: <testable truth>
Demo: <walkthrough/checks>
Stories: Story | Outcome | Unlocks | Done
Out/success/pivot: <scope boundary, proof, revise signal>
```

## Pressure Scenarios

- Small fix stays `direct_task` or `small_change`.
- A decisive unknown becomes a `spike`, not a fake full plan.
- Risky work carries proof needs before execution.
- Current work stays small enough for one bounded execution pass.
