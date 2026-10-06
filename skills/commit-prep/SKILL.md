---
name: commit-prep
description: Detect the repo's commit convention, split changes into coherent commits, and write short commit messages. Only runs `git add` or `git commit` when the user explicitly asks. Use when the user mentions commit message, conventional commits, Angular commits, kernel patch format, Signed-off-by, Fixes, split commit, squash, or asks to prepare or make a commit.
---

# Commit Prep

## Workflow

1. Read `git status`, `git diff`, `git log` first.
2. Pick the convention (first match wins):
   - user request
   - repo docs or commit tooling config
   - recent `git log` style
   - kernel signals (`Signed-off-by` on every commit, `Fixes: <12-char sha>`) -> kernel patch
   - fallback: Conventional Commits
   If signals conflict, say so. Never mix conventions.
3. One commit per coherent intent. Split unrelated fixes, refactors, docs, formatting. Keep together what only works as one unit.
4. Draft each message from the matching template in `templates/`.
5. Default is plan + message only. Run `git add` / `git commit` only if the user explicitly asks; stage only the intended files.

## Message rules

Keep it short. The diff already shows what changed; the message says why.

- Subject: imperative, lowercase, no period, <= 72 chars.
- Body: omit unless the why is not obvious. When present, 1-3 short lines.
- No bullet lists of changed files, no restating the diff.
- Footers only when needed: `BREAKING CHANGE:`, `Fixes #123`.

## Conventions

- Conventional: `type(scope): description`, `!` or `BREAKING CHANGE:` for breaking. Types: feat, fix, docs, refactor, perf, test, build, ci, revert.
- Angular: same header; lines <= 100 chars; body required except for `docs`.
- Kernel: `subsystem: summary`, body (problem, impact, fix) wrapped ~75 cols, `Signed-off-by:` required (`git commit -s`), `Fixes: <12-char sha> ("original summary")`. No `feat:`/`fix:` prefixes.
