---
name: commit-prep
description: Detect the right commit convention from repo truth, shape changes into coherent commits, write commit messages and footers, and optionally execute `git add` or `git commit` when the user explicitly asks. Use when the user mentions commit message, conventional commits, Angular commits, Linux kernel patch format, Signed-off-by, Fixes, split commit, squash, staged changes, git status, git diff, git log, or asks you to prepare or make a commit.
---

# Commit Prep

## Quick start

1. Inspect local truth before choosing a convention:
   - docs or contribution rules
   - config or tooling signals
   - recent commit history
   - patch trailers already used in the repo
2. Choose the narrowest matching reference first.
3. Fall back to Conventional Commits only when the repo gives no clear signal.
4. Default to analysis and recommendation. Only perform `git add` or `git commit` if the user explicitly asks.
5. Keep commit slices coherent. Prefer multiple focused commits over one mixed commit when the change set crosses concerns.

Example routing:
- "Write a commit message for this diff" -> `references/convention-detection.md`, then one convention reference
- "Should this be one commit or three?" -> `references/commit-shaping.md`
- "Does this repo look Angular-style or Conventional?" -> `references/convention-detection.md`
- "This worktree is dirty. How should I split it?" -> `references/commit-shaping.md`
- "Prepare a kernel-style patch commit" -> `references/kernel-patch-format.md`, then `templates/kernel-patch.txt`
- "Add Signed-off-by and Fixes correctly" -> `references/execution-and-trailers.md`
- "Actually commit these staged changes" -> `references/execution-and-trailers.md`

## Rules

- Read `git status`, `git diff`, and `git log` before proposing a commit plan when the repo is available.
- Prefer repo-truth over asking the user which convention to use.
- Separate convention detection, commit shaping, message writing, and execution.
- Do not treat `git commit` as the default end state. Many requests only need a plan or a message.
- Only recommend Linux-kernel patch structure when the repo truth or user request clearly points there.
- Keep SKILL.md as the router. Put detailed rules and examples in `references/` and reusable skeletons in `templates/`.

## Workflows

### Prepare commits from a change set

1. Inspect the current change shape and look for mixed concerns.
2. Read `references/convention-detection.md` to select the convention.
3. Read `references/commit-shaping.md` to decide whether to keep one commit or split a series.
4. Use the matching convention reference and template to draft the header, body, and footers.

### Write or review a commit message

1. Confirm the target convention from repo truth or the user request.
2. Open the matching convention reference and template.
3. Check subject style, body expectations, footer rules, and breaking or patch trailers.
4. Use `references/review-checklist.md` before claiming the message is ready.

### Execute a real commit

1. Confirm the user explicitly asked for an actual commit.
2. Read `references/execution-and-trailers.md`.
3. Preserve the planned split, commit only the intended changes, and use the selected convention.

## Further reading

- `references/convention-detection.md` -- inspect docs, config, history, and trailers to choose the right convention
- `references/commit-shaping.md` -- decide whether to keep one commit, split a series, or defer a mixed change set
- `references/conventional-commits.md` -- Conventional Commits structure, types, scopes, and breaking changes
- `references/angular-commits.md` -- Angular commit format, line-length rules, body expectations, and issue footers
- `references/kernel-patch-format.md` -- Linux kernel patch subjects, body structure, and trailer expectations
- `references/execution-and-trailers.md` -- execution boundary, `Signed-off-by`, `Fixes:`, and when to actually run `git add` or `git commit`
- `references/review-checklist.md` -- final checklist before claiming a commit plan or message is ready
- `templates/conventional-commit.txt` -- reusable Conventional Commits skeleton
- `templates/angular-commit.txt` -- reusable Angular-style commit skeleton
- `templates/kernel-patch.txt` -- reusable Linux-kernel-style patch skeleton
