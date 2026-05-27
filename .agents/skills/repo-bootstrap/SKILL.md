---
name: repo-bootstrap
description: Use when starting work in an unfamiliar repository, resuming after context loss, needing to discover the real source of truth before editing code, or turning a rough onboarding prompt into an execution-ready repo-orientation prompt.
metadata:
  dependencies: []
---

# Repo Bootstrap

Build context from the repo's real constraints before changing anything.

## Quick start

- Read `AGENTS.md` and `README.md` completely before deeper inspection.
- Decide whether the job is `Prompt-only`, `Repo bootstrap`, or `Prompt + bootstrap`.
- Identify the highest-signal source of truth for the task.
- Summarize the repo from inspected files, not from directory names alone.

## Workflows

1. Choose the mode:
   - `Prompt-only`: refine a rough bootstrap prompt and return the upgraded version.
   - `Repo bootstrap`: inspect the repo and deliver a grounded onboarding summary.
   - `Prompt + bootstrap`: do both in one pass.
2. Read `AGENTS.md` and `README.md`. This is mandatory, not optional.
3. Identify the real source of truth for the task:
   - docs
   - tests
   - current code
   - runtime checks
4. Map entrypoints, affected paths, and major subsystems from source, not from folder names alone.
5. Find the smallest relevant verification commands.
6. End with a practical handoff that captures:
   - repo purpose
   - architecture and runtime model
   - major components
   - key commands and conventions
   - open questions
   - best next files to read

## Hard gate

Do not move into planning or implementation until:

- `AGENTS.md` and `README.md` were read when present
- the summary is grounded in files you actually inspected
- repo conventions, key workflows, and verification commands are clear enough for the next step

If sources conflict, stop and resolve the conflict before coding.

## Further reading

- `references/prompt-template.md` - reusable full and compact bootstrap prompts for repo orientation
