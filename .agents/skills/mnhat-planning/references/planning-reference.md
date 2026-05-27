# Planning Reference

Use when `mnhat-planning` needs quality rules or artifact schemas.

## Quality Rules

- Choose one mode first: `direct_task`, `spike`, `small_change`, `standard_feature`, or `high_risk_feature`.
- Use the lightest workflow that honestly protects the work.
- Use one work shape for the approved slice. Do not expand planning artifacts unless the contract explicitly changes.
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
| `standard_feature` | ordered user or system capability | work shape + current story pack |
| `high_risk_feature` | external, security, data, or broad-blast work | work shape + current story pack + explicit proof needs |

Above `small_change`, record why smaller modes are insufficient.

Write planning artifacts inside `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/`.

Use the dedicated templates for:

- `references/approach-template.md`
- `references/alternatives-template.md`
- `references/risk-map-template.md`
- `references/work-shape-template.md`
- `references/current-story-pack-template.md`
- `references/verification-plan-template.md`

## Pressure Scenarios

- Small fix stays `direct_task` or `small_change`.
- A decisive unknown becomes a `spike`, not a fake full plan.
- Risky work carries proof needs before execution.
- Current work stays small enough for one bounded execution pass.
