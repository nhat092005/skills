---
name: using-mnhat
description: Use when starting or resuming a repo session and needing to route the work into the right mnhat skill or run the full mnhat workflow.
---

# using-mnhat

Use this as the thin bootstrap for the mnhat workflow. It should do only three things:

1. read `AGENTS.md`
2. surface `.mnhat/session/HANDOFF.json` if present and wait for confirmation before resuming
3. route to the next skill from real task state and current `bd` context

## Route

- vague request or unresolved product decisions -> `exploring`
- clear request that still needs a work shape -> `planning`
- approved plan that still needs proof -> `validating`
- one approved bounded slice -> `executing`
- approved slice plus explicit delegation request -> `swarming`
- implemented work that needs findings or UAT -> `reviewing`
- finished or intentionally abandoned work with reusable lessons -> `compounding`
- rough autonomous objective -> `goal-griller`

Default to `exploring` for ambiguity and `planning` for clear but still unshaped work.

## Go Mode

If the user wants the full flow, run:

```text
exploring -> planning -> validating -> executing or swarming -> reviewing -> compounding
```

Keep only these gates:

1. approve locked context before planning
2. approve work shape before execution prep
3. approve validated current work before execution
4. acknowledge `P1` review findings before calling work complete
5. finish closeout before ending the session through `compounding`

## Contracts

- `.mnhat` is for active artifacts and transient handoff only.
- `bd` is the durable task tracker.
- `bd remember` is durable project memory.
- Do not delegate unless the user explicitly wants delegation.

Load `references/routing-and-contracts.md` only if the route is unclear. Load `references/go-mode-pipeline.md` only if the user wants the full workflow.
