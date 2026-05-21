---
name: repo-bootstrap
description: Use when starting work in an unfamiliar repository, resuming after context loss, needing to discover the real source of truth before editing code, or turning a rough onboarding prompt into an execution-ready repo-orientation prompt.
metadata:
  dependencies: []
---

# Repo Bootstrap

Build context from the repo's real constraints before changing anything.

Load [references/prompt-template.md](references/prompt-template.md) when the user wants a reusable bootstrap prompt or when you need a strong starting template before beginning repo discovery.

## Modes

- `Prompt-only`: refine the user's rough prompt and return the upgraded version.
- `Repo bootstrap`: read the repo, investigate source, deliver onboarding summary.
- `Prompt + bootstrap`: do both in the same pass.

## Workflow

1. Read `AGENTS.md` and `README.md` completely. Mandatory, not optional.
2. Identify the source of truth for the task: docs, tests, current code, or runtime checks.
3. Map entrypoints, affected paths, and major subsystems from source — not from directory names alone.
4. Find the smallest relevant verification commands.
5. Only then move into planning or implementation.

## Rules

- Do not trust old plans without re-checking the live repo.
- Prefer narrow inspection over broad file dumps.
- If sources conflict, stop and resolve before coding.
- Every claim in the summary must trace back to a file you actually read.

## Red Flags

Stop and correct if any of these appear:

- Skipping or skimming `AGENTS.md` / `README.md`
- Inferring architecture from directory names alone
- Jumping into code before reading repo instructions
- Giving a vague summary with no file-grounded evidence

## Done Criteria

This skill is complete when:

- `AGENTS.md` and `README.md` were read fully
- Project purpose and architecture are explained from inspected source
- Main components, workflows, and verification commands are identified
- Repo conventions and open questions are captured clearly enough for the next turn to start productively
