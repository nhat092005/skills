# Execution and Trailers

Control when the skill only drafts a commit and when it may actually create one.
Read this when the user asks for a real commit or when trailers such as `Signed-off-by:` and `Fixes:` matter.

## Default execution boundary

- Analyze first.
- Recommend commit grouping, convention, message, and trailers by default.
- Only run `git add` or `git commit` when the user explicitly asks for actual commit execution.

## Real commit workflow

1. Confirm the intended commit split.
2. Stage only the changes that belong to the selected commit.
3. Write the message in the chosen convention.
4. Add required trailers before committing.
5. Keep unrelated dirty changes out of the commit.

## Trailer rules

- `Signed-off-by:`
  - required for Linux-kernel-style patch commits
  - use `git commit -s` when the user explicitly wants or needs a real signed-off commit
- `Fixes:`
  - kernel style expects a 12-character SHA plus the original summary in quotes
- `Fixes #123` or `Closes #123`
  - common for Angular-style issue footers
- `BREAKING CHANGE:`
  - use for Conventional or Angular-style breaking changes when relevant

## Command boundary guidance

- `git status`
  - inspect staged, unstaged, and untracked changes
- `git diff`
  - inspect actual changes for grouping and message drafting
- `git log`
  - inspect the existing convention
- `git add`
  - only when executing a real commit
- `git commit`
  - only when executing a real commit

## Related references

- `references/commit-shaping.md`
- `references/kernel-patch-format.md`
- `references/angular-commits.md`
- `references/conventional-commits.md`
