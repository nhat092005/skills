# Angular Commits

Use this when repo truth points to Angular-style commit messages or the user explicitly requests it.
Read this when the chosen format is Angular commit style.

## Core structure

`<type>(<scope>): <short summary>`

Body follows after one blank line.
Footer is optional and follows after one blank line after the body.

## Key rules

- Header is required.
- Body is required for all commit types except `docs`.
- When present, the body should be at least 20 characters and actually explain the reason for the change.
- Body should be meaningful, not filler.
- Use present tense and imperative mood.
- Do not capitalize the first word of the summary.
- Do not end the summary with a period.
- Keep every line at or under 100 characters.

## Common types

- `build`
- `ci`
- `docs`
- `feat`
- `fix`
- `perf`
- `refactor`
- `test`

## Footer usage

- Use `BREAKING CHANGE:` for breaking behavior and migration notes.
- Use issue footers such as `Fixes #123` or `Closes #123` when relevant.
- Deprecation notes can be expressed with `DEPRECATED:` followed by guidance.

## Related template

- `templates/angular-commit.txt`
