# Commit Shaping

Shape the change set into sensible commit boundaries before writing messages.
Read this when the user has a dirty worktree, mixed staged changes, or asks whether to split commits.

## Default rule

- One commit per coherent intent.
- Split when the same diff mixes unrelated behavior, mechanical cleanup, refactors, or follow-up fixes.
- Keep one commit when the change only makes sense as a single behavioral unit.
- Squash when multiple tiny pieces are really one story and separate commits would only create noise.

## Signals to split

- Independent bug fix and refactor in the same diff
- Production code plus unrelated docs or formatting
- Multiple subsystems with no shared story
- Mechanical rename plus behavioral change
- Separate test-only change that can stand alone

## Signals to keep together

- The code and tests form one inseparable fix
- The refactor is required to make the actual fix or feature possible
- The change is small and clearly supports one intent

## Output expectations

For each proposed commit, define:

- intent
- likely convention and scope or subsystem
- whether body is required
- which footers or trailers apply

## Execution boundary

- By default, only propose the split and message plan.
- Only move into `git add` and `git commit` when the user explicitly asks for actual commit execution.

## Related references

- `references/convention-detection.md`
- `references/execution-and-trailers.md`
