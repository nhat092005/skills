---
name: session-handoff
description: Create a temporary handoff note for opening a new chat from a live MNHAT workstream. Use when the user explicitly asks to compact, hand off, or resume work in a fresh session without replacing `.mnhat` as the source of truth.
---

# Session Handoff

## Quick start

- Read `.mnhat/state.json` first and refuse if it is missing or invalid for the current contract.
- Use `workstream_dir` as the only source for choosing the handoff filename.
- Read the canonical workstream artifacts before summarizing.
- Write one temporary markdown file to `/tmp/codex-handoffs/<YYYY-MM-DD>-<feature-slug>-handoff.md`.
- Return only the path, workstream, phase, and recommended next skill in chat.

## Workflows

1. Confirm `.mnhat/state.json` exists and contains a valid `workstream_dir`.
2. Read:
   - `.mnhat/state.json`
   - `primary_artifact`
   - `artifact_paths[]`
   - `implementation-record.md` when present
3. Refuse the handoff if canonical state is missing or too stale to trust.
4. Build the handoff from two layers:
   - `Canonical State` from `.mnhat`
   - `Ephemeral Chat Context` from the current conversation
5. If the user passed an argument, record it as `Next Session Focus`.
6. If the focus conflicts with canonical state, warn clearly but still write the handoff.
7. Keep `Suggested Skills` to at most three items. The first item must be the recommended next skill.
8. Overwrite the existing workstream handoff file instead of creating timestamped variants.

## Hard gate

- `.mnhat` remains the canonical source of truth. This skill must not replace it.
- This skill is read-only with respect to `.mnhat`.
- Refuse if `.mnhat/state.json` is missing, `workstream_dir` is missing, or the workstream cannot be trusted.
- Do not create a parallel runtime state system. The handoff file is only a temporary derived summary for the next chat.

## Further reading

- `references/session-handoff-template.md` - locked output format for the temp handoff file
- `../mnhat/SKILL.md` - canonical runtime family that this skill reads from
- `../mnhat/references/state-resume-checklist.md` - trust checks for `.mnhat/state.json` and artifact selection
