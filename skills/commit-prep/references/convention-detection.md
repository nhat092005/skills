# Convention Detection

Choose the commit convention from repo truth before writing anything.
Read this first when the repo or request does not already make the format explicit.

## Detection order

1. User override
   - If the user explicitly asks for Conventional, Angular, or Linux-kernel style, use that.
2. Repo docs and config
   - Check contribution docs, commit tooling, and local rules that clearly specify a format.
3. Recent commit history
   - Look at recent subjects, body structure, and trailers.
4. Patch trailers and workflow clues
   - `Signed-off-by:` on every commit, `Fixes:` with a 12-character SHA, or email-patch workflow clues point toward kernel-style patch format.
5. Fallback
   - If no strong signal exists, use Conventional Commits.

## Heuristics

- Conventional Commits
  - `type(scope): description`
  - often paired with release or changelog tooling
- Angular style
  - also `type(scope): summary`, but stricter expectations around line length and body usage
  - common types include `build`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `test`
- Linux kernel patch style
  - `subsystem: summary`
  - mandatory explanatory body
  - `Signed-off-by:` required

## Conflict handling

- If docs and history disagree, prefer the stronger explicit policy in current repo docs or config.
- If the signal is mixed and weak, state that and fall back to Conventional Commits.
- Do not silently combine conventions.

## Related references

- `references/conventional-commits.md`
- `references/angular-commits.md`
- `references/kernel-patch-format.md`
