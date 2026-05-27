# Session Handoff Template

Write the handoff file to:

```text
/tmp/codex-handoffs/<YYYY-MM-DD>-<feature-slug>-handoff.md
```

Create `/tmp/codex-handoffs/` if it does not exist. Overwrite the existing workstream handoff file if it already exists.

Use this exact structure:

```markdown
# Session Handoff: <workstream>

## Canonical State
- Workstream: <workstream_dir>
- Phase: <phase>
- Current Work: <current_work.title>
- Status: <status>
- Primary Artifact: <primary_artifact>
- Resume Point: <resume_point>
- Canonical Sources:
  - `.mnhat/state.json`
  - `<primary_artifact>`
  - `<implementation-record.md if present>`
  - `<1-2 additional canonical artifacts when they materially help resume>`
- Important Artifacts:
  - `<primary_artifact>`
  - `<implementation-record.md if present>`
  - `<1-2 immediate source artifacts, not a full artifact_paths dump>`
- Warnings: <none | concise warning list>

## Ephemeral Chat Context
- Next Session Focus: <argument or none>
- User Intent In Plain Words: <short plain-language statement>
- Important Nuance: <important nuance or none>
- Recent Decisions Not Obvious From Artifact Order: <short list or none>
- Suggested Read Order:
  1. `<first file>`
  2. `<second file>`
  3. `<third file if needed>`
- Suggested Skills:
  1. `<recommended next skill>` - <one-line reason>
  2. `<support skill if needed>` - <one-line reason>
  3. `<support skill if needed>` - <one-line reason>
- First Question To Re-open With: <question or none>
```

Rules:

- `Canonical State` is derived from `.mnhat`, not from memory alone.
- `Ephemeral Chat Context` may include chat-only nuance, but it must not override canonical truth.
- If the user-provided focus conflicts with canonical state, keep the focus but record the conflict in `Warnings` and `Important Nuance`.
- Keep `Important Artifacts` intentionally small. Do not dump all of `artifact_paths[]`.
- If no trustworthy canonical state exists, do not write the handoff file.
