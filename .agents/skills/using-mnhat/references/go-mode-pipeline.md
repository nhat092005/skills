# Go Mode Pipeline

Use this only when the user explicitly wants the full mnhat workflow.

## Sequence

```text
exploring
  -> Gate 1: approve locked context
planning
  -> Gate 2: approve work shape
validating
  -> Gate 3: approve validated current work
executing or swarming
reviewing
  -> Gate 4: acknowledge P1 findings or confirm clean review
compounding
  -> Gate 5: close out `bd` and git session state before ending the session
```

## Notes

- `exploring`: lock decisions, write `CONTEXT.md`, stop for approval
- `planning`: choose the lightest safe shape, write planning artifacts, stop for approval
- `validating`: prove repo fit, write `validation-report.md`, stop for approval
- `executing` or `swarming`: implement only approved current work
- `reviewing`: run the final quality gate and document findings
- `compounding`: capture lessons with `bd remember`, create real follow-up `bd` work, and finish closeout if the session is ending

## Pause And Resume

If the session must pause, write `.mnhat/session/HANDOFF.json` or the active skill's handoff artifact, then never auto-resume without confirmation.
