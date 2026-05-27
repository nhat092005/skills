# State Resume Checklist

Use this after opening `.mnhat/state.json` to decide whether the snapshot is trustworthy and what to open next.

## 1. Snapshot Sanity

1. Confirm `.mnhat/state.json` exists and parses as valid JSON.
2. Confirm `schema_version` is `1`.
3. Confirm `status` is one of `active`, `paused`, `done`, `superseded`, or `invalid`.
4. Confirm `phase` is one of the canonical MNHAT phases.
5. Confirm `workstream_dir` matches `.mnhat/<YYYY-MM-DD>-<feature-slug>`.
6. Confirm `feature_slug` matches the suffix of `workstream_dir`.

## 2. Artifact Integrity

1. Confirm `primary_artifact` appears in `artifact_paths[]`.
2. Confirm every `.mnhat/...` path in `artifact_paths[]` lives under `workstream_dir`.
3. Confirm the phase artifact in `primary_artifact` matches `phase`.
4. If `implementation-record.md` exists, confirm it also appears in `artifact_paths[]`.
5. Confirm all runtime artifact filenames are lowercase.

## 3. Resume Readiness

1. Open `primary_artifact` first.
2. Open `implementation-record.md` next when it exists.
3. Open the immediate source artifact that fed the phase, such as:
   - `exploring/context.md` before planning
   - `planning/current-story-pack.md` before validating or executing
   - `validating/validation-report.md` before executing or swarming
4. Read `resume_point`.
5. Run each command or check listed in `resume_checks`.

## 4. Trust Decision

- Resume normally when path invariants hold and the active artifact still reflects real work.
- Ask for confirmation before resuming when `status` is `active` or `paused`.
- Refuse automatic resume when `status` is `done`, `superseded`, or `invalid`.
- Mark the snapshot stale or invalid before continuing if the artifacts contradict the real repo state.

## 5. Runtime Expectations

1. Phase directories exist under the workstream even if some files do not yet exist.
2. Files should be created only when they have real content.
3. If a file exists, even short content should follow the canonical template.
4. Meaningful decisions, blockers, defers, tradeoffs, and no-change outcomes belong in `implementation-record.md`.
