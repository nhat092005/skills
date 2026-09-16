# Conventional Commits

Use this for the standard fallback and for repos that explicitly use Conventional Commits.
Read this when the chosen format is Conventional Commits.

## Core structure

`<type>[optional scope][optional !]: <description>`

Optional body follows after one blank line.
Optional footers follow after one blank line after the body.

## Minimum required behavior

- Use `feat` for a new feature.
- Use `fix` for a bug fix.
- Place the description immediately after `: `.
- Use `!` or a `BREAKING CHANGE:` footer for breaking changes.

## Good defaults

- Keep the summary short, imperative, and consistent in style.
- Use scope when it materially clarifies which module changed.
- Add a body when the reason or tradeoff is not obvious from the diff.
- Use footers for references or breaking changes, not for repeating the summary.

## Common types

- `feat`
- `fix`
- `docs`
- `refactor`
- `perf`
- `test`
- `build`
- `ci`
- `revert`

## Breaking changes

- `feat!: drop support for Node 6`
- `feat(api)!: remove deprecated endpoint`
- Footer form:
  - `BREAKING CHANGE: explain the migration impact clearly`

## Related template

- `templates/conventional-commit.txt`
