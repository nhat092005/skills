# State Contract

Canonical runtime artifact contract for the global MNHAT workflow family.

## Purpose

Use `.mnhat/` as the local-only runtime workspace for active MNHAT workflow state and workstream artifacts.

- `.mnhat/state.json` is the only top-level state snapshot file.
- Each workstream lives under `.mnhat/<YYYY-MM-DD>-<feature-slug>/`.
- Runtime artifact filenames are lowercase and fixed by contract.
- Phase directories are fixed for every workstream.
- Files are created only when they have real content. If they exist, even short content must follow the canonical template.
- `.mnhat/` is local-only and should be ignored by git-aware repos.

## Canonical Tree

```text
.mnhat/
├── state.json
└── <YYYY-MM-DD>-<feature-slug>/
    ├── implementation-record.md
    ├── exploring/
    │   ├── context.md
    │   ├── open-questions.md
    │   └── resolved-questions.md
    ├── planning/
    │   ├── approach.md
    │   ├── alternatives.md
    │   ├── risk-map.md
    │   ├── work-shape.md
    │   ├── current-story-pack.md
    │   └── verification-plan.md
    ├── validating/
    │   └── validation-report.md
    ├── executing/
    │   └── execution-report.md
    ├── swarming/
    │   └── dispatch-plan.md
    ├── debugging/
    │   └── debug-report.md
    ├── reviewing/
    │   ├── review-report.md
    │   ├── requirements-check.md
    │   └── uat-notes.md
    └── compounding/
        ├── compounding-report.md
        ├── memory-candidates.md
        └── follow-up-work.md
```

## Fixed Directories And File Set

Each workstream directory always contains these fixed phase directories:

- `exploring/`
- `planning/`
- `validating/`
- `executing/`
- `swarming/`
- `debugging/`
- `reviewing/`
- `compounding/`

Approved file set:

- root:
  - `implementation-record.md`
- `exploring/`:
  - `context.md`
  - `open-questions.md`
  - `resolved-questions.md`
- `planning/`:
  - `approach.md`
  - `alternatives.md`
  - `risk-map.md`
  - `work-shape.md`
  - `current-story-pack.md`
  - `verification-plan.md`
- `validating/`:
  - `validation-report.md`
- `executing/`:
  - `execution-report.md`
- `swarming/`:
  - `dispatch-plan.md`
- `debugging/`:
  - `debug-report.md`
- `reviewing/`:
  - `review-report.md`
  - `requirements-check.md`
  - `uat-notes.md`
- `compounding/`:
  - `compounding-report.md`
  - `memory-candidates.md`
  - `follow-up-work.md`

No other runtime filenames are allowed inside a workstream tree unless the contract is explicitly revised.

## Artifact Ownership

- `mnhat-exploring` owns:
  - `context.md`
  - `open-questions.md`
  - `resolved-questions.md`
- `mnhat-planning` owns:
  - `approach.md`
  - `alternatives.md`
  - `risk-map.md`
  - `work-shape.md`
  - `current-story-pack.md`
  - `verification-plan.md`
- `mnhat-validating` owns `validation-report.md`
- `mnhat-executing` owns `execution-report.md`
- `mnhat-swarming` owns `dispatch-plan.md`
- `mnhat-debugging` owns `debug-report.md`
- `mnhat-reviewing` owns:
  - `review-report.md`
  - `requirements-check.md`
  - `uat-notes.md`
- `mnhat-compounding` owns:
  - `compounding-report.md`
  - `memory-candidates.md`
  - `follow-up-work.md`
- `mnhat-implementation-record` owns `implementation-record.md`

## Naming Rules

- `feature_slug` is lowercase kebab-case and stays stable for the whole workstream.
- A workstream directory is named `<YYYY-MM-DD>-<feature-slug>`.
- The date prefix is the workstream creation date and never changes.
- If a workstream resumes later, reuse the same workstream directory.
- `state.json.workstream_dir` is required and points to the active workstream directory.
- `feature_slug` must match the suffix of `workstream_dir`.
- All artifact paths stored in `state.json` are relative to repo root, use `/`, are sorted lexically, and contain no duplicates.

## Forbidden Legacy Paths

- `.mnhat/session/`
- any `HANDOFF.json`
- `.mnhat/implementation-notes/`
- `.mnhat/implementation-notes.md`
- `.mnhat/exploring/<feature-slug>/CONTEXT.md`
- any phase-first live path such as `.mnhat/planning/<feature-slug>/...`

## `state.json`

`state.json` is the only current snapshot of active MNHAT workflow state. It is not a history log.

- Write it only at meaningful state checkpoints, not as a live event stream.
- If `status` is `active` or `paused`, resume requires explicit user confirmation.
- If the snapshot is no longer trustworthy, mark it `invalid` instead of silently guessing.

Top-level fields:

- `schema_version`
- `created_at`
- `updated_at`
- `last_actor`
- `mode`
- `status`
- `outcome`
- `phase`
- `feature_slug`
- `workstream_dir`
- `current_work`
- `primary_artifact`
- `artifact_paths`
- `write_paths`
- `completed_steps`
- `remaining_steps`
- `resume_point`
- `resume_checks`
- `verification_state`
- `worktree_state`
- `branch`
- `head_commit`
- `active_slices`
- `context_notes`

Enums:

- `mode`: `solo | swarm`
- `status`: `active | paused | done | superseded | invalid`
- `outcome`: `none | blocked | cancelled | replaced`
- `phase`: `exploring | planning | validating | executing | swarming | debugging | reviewing | compounding`
- `verification_state.status`: `not_started | in_progress | passed | failed`
- `active_slices[].status`: `not_started | in_progress | done | blocked | paused | noop`

Rules:

- `mode: "swarm"` requires `phase: "swarming"` and `active_slices.length >= 1`.
- `mode: "solo"` requires `active_slices = []`.
- `primary_artifact` must also appear in `artifact_paths`.
- `artifact_paths` must be non-empty.
- `feature_slug` exists only at top level.
- `current_work` contains:
  - `tracker_type`
  - `tracker_id`
  - `title`
  - `scope`
- `created_at` and `updated_at` use ISO 8601 with timezone offset.
- `head_commit` is a full 40-character SHA.
- `last_actor` is one of:
  - `codex`
  - `user`
  - `orchestrator`
  - `worker:<slice-id>`

## Primary Artifact Defaults

Use the canonical phase artifact as the primary artifact:

- `exploring` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/exploring/context.md`
- `planning` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/planning/current-story-pack.md`
- `validating` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/validating/validation-report.md`
- `executing` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/executing/execution-report.md`
- `swarming` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/swarming/dispatch-plan.md`
- `debugging` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/debugging/debug-report.md`
- `reviewing` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/reviewing/review-report.md`
- `compounding` -> `.mnhat/<YYYY-MM-DD>-<feature-slug>/compounding/compounding-report.md`

## Implementation Record Rules

`implementation-record.md` is a cross-phase workstream artifact, not a `phase`.

- Keep it at workstream root: `.mnhat/<YYYY-MM-DD>-<feature-slug>/implementation-record.md`
- Create it on first meaningful entry, not as a placeholder.
- Update it whenever a meaningful decision, blocker, defer, tradeoff, or `no-change` outcome should survive resume.
- When it exists, include it in `state.json.artifact_paths[]`.
- It should not replace the current phase artifact as `primary_artifact`.

## Artifact Path Expectations

When available, `artifact_paths[]` should usually include:

1. the current phase artifact
2. `.mnhat/<YYYY-MM-DD>-<feature-slug>/implementation-record.md`
3. the immediate source artifact that led into the phase, such as `current-story-pack.md` or `validation-report.md`

## Resume Behavior

Startup recovery reads `.mnhat/state.json` first.

- If `status` is `active` or `paused`, surface the snapshot and wait for confirmation before resuming.
- If `status` is `done`, `superseded`, or `invalid`, do not treat it as an automatic resume candidate.
- If a legacy state path is found, treat it as invalid input and do not resume from it.

## Reference Files

- `state.schema.json` is the machine-readable contract.
- `state-example.json` is the canonical example snapshot.
- `state-resume-checklist.md` is the operator checklist for resume trust and path validation.
