---
name: mnhat
description: Route repo work into the MNHAT workflow family and recover active runtime state. Use when starting or resuming a repo session, deciding the next MNHAT phase, or running the full MNHAT workflow.
---

# MNHAT

## Quick start

- Read `AGENTS.md`.
- If present, surface `.mnhat/state.json` when `status` is `active` or `paused`, then wait for confirmation before resuming.
- Re-open the current source-of-truth artifact under `.mnhat/`.
- Route to the next `mnhat-*` phase skill from real task state and current `bd` context.

## Workflows

Route table:

- vague request or unresolved product decisions -> `mnhat-exploring`
- clear request that still needs a work shape -> `mnhat-planning`
- approved plan that still needs proof -> `mnhat-validating`
- one approved bounded slice -> `mnhat-executing`
- approved slice plus explicit delegation request -> `mnhat-swarming`
- blocked implementation or failing verification -> `mnhat-debugging`
- implemented work that needs findings or UAT -> `mnhat-reviewing`
- finished or intentionally abandoned work with reusable lessons -> `mnhat-compounding`
- rough autonomous objective -> `goal-griller`

Internal-only sub-skill:

- `mnhat-implementation-record` is called by phase skills when a meaningful decision must be recorded.

Full flow:

```text
mnhat-exploring -> mnhat-planning -> mnhat-validating -> mnhat-executing or mnhat-swarming -> mnhat-reviewing -> mnhat-compounding
```

## State rules

- `.mnhat/state.json` is the only top-level runtime state file.
- Workstreams live under `.mnhat/<YYYY-MM-DD>-<feature-slug>/`.
- Runtime artifacts live inside the active workstream tree under `<workstream>/<phase>/...`.
- `implementation-record.md` is required when a meaningful decision must be recorded, even for `no-change`, `blocked`, or `deferred` outcomes.
- `bd` is durable task tracking. `bd remember` is durable project memory.

## Further reading

- `references/routing-and-contracts.md` - route table, runtime ownership, and per-phase artifact map
- `references/go-mode-pipeline.md` - full gated workflow
- `references/state-contract.md` - canonical `.mnhat` contract
- `references/state.schema.json` - strict schema for `.mnhat/state.json`
- `references/state-example.json` - example workstream-first state snapshot
- `references/state-resume-checklist.md` - runtime resume and validation checklist
