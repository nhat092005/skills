---
name: zoom-out-architecture
description: Use when a local change may hide broader architectural coupling, naming drift, or complexity growth and you need to evaluate it in system context before proceeding.
---

# Zoom Out Architecture

Pause local optimization long enough to ask whether the surrounding design still makes sense. The aim is to prevent accidental complexity from spreading one patch at a time.

## Quick start

- Identify the module or entrypoint being changed.
- Trace the nearest dependencies, callers, and boundary crossings.
- Check whether the change extends an existing concept or creates a sibling abstraction.
- Stop with a short architectural impact summary before proceeding.

## Workflows

1. Use this skill when:
   - a small change touches several modules
   - new logic duplicates an existing concept
   - a fix starts leaking complexity across boundaries
   - the user asks for architecture review or broader context
2. Start from the concrete entrypoint or module being changed.
3. Trace nearby dependencies, callers, and shared concepts.
4. Check whether the change:
   - deepens an existing module safely
   - creates new surface area
   - introduces naming drift
   - crosses a boundary that should stay narrow
5. End with a short architectural impact summary:
   - what is affected
   - what design risk exists
   - whether to proceed, refactor first, or stop and escalate

## Hard gate

- Favor deeper modules with simpler interfaces.
- Prefer extending an existing concept over inventing a sibling abstraction.
- Call out when a quick fix increases long-term coupling.
- Do not approve a local patch without naming the boundary or coupling cost when one exists.

## Further reading

- `../repo-bootstrap/SKILL.md` - use first when the repo or subsystem is still too unfamiliar for architecture judgment
- `../plan-griller/SKILL.md` - use when the main blocker is ambiguity in scope or implementation target rather than architectural coupling
