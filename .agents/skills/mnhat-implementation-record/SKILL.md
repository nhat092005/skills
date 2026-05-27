---
name: mnhat-implementation-record
description: Record meaningful implementation decisions for an active MNHAT workstream. Use when a phase skill needs to append a canonical implementation record entry for a change, no-change decision, blocker, defer, or tradeoff.
---

# MNHAT Implementation Record

## Quick start

- Use only from another `mnhat-*` phase skill.
- Append a new entry to `.mnhat/<YYYY-MM-DD>-<feature-slug>/implementation-record.md`.
- Record meaningful decisions even when no file changed.
- Do not take over the phase artifact owned by another skill.

## Workflows

1. Confirm the active `feature-slug`, phase, and current work.
2. Create `implementation-record.md` only when the first real entry exists.
3. Append one entry using the canonical vocabulary and template.
4. Keep the file entry-based and additive; do not rewrite prior entries unless correcting them.

## Outputs

- Canonical artifact: `.mnhat/<YYYY-MM-DD>-<feature-slug>/implementation-record.md`
- Canonical template owner: `references/implementation-record-template.md`

## State rules

- `implementation-record.md` is not a `state.json.phase`.
- Include it in `state.json.artifact_paths[]` when it exists.
- It is required whenever a meaningful decision, blocker, defer, no-change outcome, or tradeoff should survive resume.

## Further reading

- `references/implementation-record-template.md` - canonical entry format and vocabulary
