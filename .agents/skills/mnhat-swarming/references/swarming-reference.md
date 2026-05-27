# Swarming Reference

Use after `mnhat-validating` approves current work and the user wants delegation.

## Slice Rules

Each worker slice must have:

- one bounded outcome
- clear ownership of files or responsibility
- concrete verification
- a blocker path if the slice stops being independent

Do not delegate slices that share active write scope.

## Worker Prompt Shape

```text
You are an execution worker.

Assigned slice:
- Current-work id: <id>
- Scope: <one bounded outcome>
- Files or ownership: <paths or module>
- Verification: <commands/checks>

Contract:
- Load `mnhat-executing`.
- Handle exactly this slice.
- Do not expand scope.
- Return one final status: [DONE], [BLOCKED], [PAUSED], or [NOOP].
```

## Orchestrator Artifact

Track `.mnhat/<YYYY-MM-DD>-<feature-slug>/swarming/dispatch-plan.md` with:

```markdown
# Swarm Dispatch: <feature-slug>

Current work: <bd item or approved slice>

| Worker | Slice | Ownership | Verification | Status | Notes |
| --- | --- | --- | --- | --- | --- |
| worker-1 | <scope> | <paths/module> | <command/check> | active | <notes> |
```

## Result Formats

```text
[DONE] <slice-id>: <summary>
Files: <paths>
Verification: <command/result>
Next action: <next>
```

```text
[BLOCKED] <slice-id>
Blocker: <what prevents safe completion>
What I need next: <specific orchestrator or user action>
```

```text
[PAUSED] <slice-id or run>
Reason: <safe pause>
Resume: read .mnhat/state.json
```

```text
[NOOP] <slice-id>
Reason: <why the slice was not safe to run>
```

Use `references/dispatch-plan-template.md` for the canonical orchestrator artifact.
