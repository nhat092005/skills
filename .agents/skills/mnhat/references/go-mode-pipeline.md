# Go Mode Pipeline

Use this only when the user explicitly wants the full mnhat workflow.

## Sequence

```text
mnhat-exploring
  -> Gate 1: approve locked context
mnhat-planning
  -> Gate 2: approve work shape
mnhat-validating
  -> Gate 3: approve validated current work
mnhat-executing or mnhat-swarming
mnhat-reviewing
  -> Gate 4: acknowledge P1 findings or confirm clean review
mnhat-compounding
  -> Gate 5: close out `bd` and git session state before ending the session
```

## Notes

- `mnhat-exploring`: lock decisions, write `context.md`, stop for approval
- `mnhat-planning`: choose the lightest safe shape, write planning artifacts, stop for approval
- `mnhat-validating`: prove repo fit, write `validation-report.md`, stop for approval
- `mnhat-executing` or `mnhat-swarming`: implement only approved current work
- `mnhat-reviewing`: run the final quality gate and document findings
- `mnhat-compounding`: capture lessons with `bd remember`, create real follow-up `bd` work, and finish closeout if the session is ending

## Pause And Resume

If the session must pause, update `.mnhat/state.json`, keep the current workstream phase artifact current, and include the workstream `implementation-record.md` in `artifact_paths[]` when it exists.
