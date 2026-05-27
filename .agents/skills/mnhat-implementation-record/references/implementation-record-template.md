# Implementation Record Template

Write this to `.mnhat/<YYYY-MM-DD>-<feature-slug>/implementation-record.md` as append-only entries.

Use one block per meaningful decision, including `no-change`, `blocked`, and `deferred` outcomes.

```markdown
# Implementation Record: <Feature>

### <Short entry title>
Type: `bug-fix | feature | spec-gap | refactor | config | docs | decision`
Status: `done | partial | blocked | deferred | no-change`
Risk: `low | medium | high`
Phase: `exploring | planning | validating | executing | swarming | debugging | reviewing | compounding`

Why:
- <why this decision or outcome mattered>

What changed:
- <code/doc/config change, or explicit no-change outcome>

Tradeoff:
- <cost, limitation, or deferred risk>

Follow-up:
- <none | exact next action>
```
