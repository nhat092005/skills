---
name: zoom-out-architecture
description: Use when a local change may hide broader architectural coupling, naming drift, or complexity growth and you need to evaluate it in system context before proceeding.
---

# Zoom Out Architecture

## Overview
Pause local optimization long enough to ask whether the surrounding design still makes sense. The aim is to prevent accidental complexity from spreading one patch at a time.

## When to Use

- A small change touches several modules.
- New logic duplicates an existing concept.
- A fix starts leaking complexity across boundaries.
- The user asks for architecture review or broader context.

## Workflow

1. Identify the module or entrypoint being changed.
2. Trace nearby dependencies and callers.
3. Check whether the change deepens an existing module or creates new surface area.
4. Look for duplication, naming drift, and boundary violations.
5. Summarize the architectural impact before implementation or refactor.

## Rules

- Favor deeper modules with simpler interfaces.
- Prefer extending an existing concept over inventing a sibling abstraction.
- Call out when a quick fix increases long-term coupling.
