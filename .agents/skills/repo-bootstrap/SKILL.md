---
name: repo-bootstrap
description: Use when starting work in an unfamiliar repository, resuming after context loss, or needing to discover the real source of truth before editing code.
---

# Repo Bootstrap

## Overview
Start by finding the repo's real operating constraints, entrypoints, and verification paths. Build context before changing code.

## When to Use

- New repository or submodule.
- Old plan may be stale.
- Project has multiple docs, services, or runtimes.

## Workflow

1. Find and read the nearest `AGENTS.md` and repo-local instruction files.
2. Identify the source of truth for the task:
   - docs
   - tests
   - current code
   - runtime checks
3. Map the likely entrypoints and affected paths.
4. Find the smallest relevant verification commands.
5. Only then move into planning or implementation.

## Rules

- Do not trust old plans without re-checking the live repo.
- Prefer narrow inspection over broad file dumps.
- If sources conflict, stop and resolve the conflict before coding.
