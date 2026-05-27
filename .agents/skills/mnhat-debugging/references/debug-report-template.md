# debug-report.md Template

Write this to `.mnhat/<YYYY-MM-DD>-<feature-slug>/debugging/debug-report.md`.

```markdown
# Debug Report: <Feature>

Status: `[DONE] | [BLOCKED]`
Type: `<build | test | runtime | integration | worker>`

## Symptom

- <exact failure summary>

## Reproduction

- <command or steps>

## Root Cause

- <file>:<line> - <what is wrong and why>

## Fix Path

- <change made or recommended>

## Verification

- <command or check> - PASS | FAIL

## Next Action

- <none | exact next action>
```
