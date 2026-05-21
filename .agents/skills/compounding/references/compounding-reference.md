# Compounding Reference

Use after `$compounding` is selected.

## Protocol

1. **Gather evidence:** read `.mnhat/` notes, beads context, review findings, debugging notes, recent diffs, and local commit history. If artifacts are missing, use the best available local evidence. Do not fabricate.
2. **Analyze:** separate findings into three lenses:
   - pattern: reusable code, process, or integration patterns
   - decision: important choices, tradeoffs, and surprises
   - failure: blockers, wrong assumptions, regressions, or missing checks
3. **Synthesize:** tag each useful finding with category, scope, and applicable-when. Convert only durable lessons into `bd remember` entries.
4. **Track follow-up:** file or update `bd` items for anything still open.
5. **Close out:** if ending the session, finish the repo closeout sequence and confirm push success.

## `bd remember` Entry Shape

Record only high-signal lessons that will help future sessions avoid waste or repeat a proven pattern.

Recommended content:

- workstream or `bd` item
- what happened
- root cause or key insight
- future rule
- evidence pointers: file paths, commands, or artifacts

Template:

```text
Workstream: <name or bd item>
Category: pattern | decision | failure
Applicable when: <future trigger>
What happened: <2-4 concrete sentences>
Root cause / key insight: <why>
Future rule: <imperative guidance>
Evidence: <files, commands, artifacts>
```

## Follow-Up `bd` Work

Create or update `bd` items when:

- review found real remaining work
- the workstream is intentionally abandoned but still needs a future return
- a wider fix should not be mixed into the completed slice

Do not create speculative epics during compounding. Track only real next work.

## Session Closeout

If this work session is ending, do not stop after writing lessons. Complete the repo closeout:

1. confirm required quality gates are complete
2. ensure `bd` follow-up is filed or updated
3. run `git pull --rebase`
4. run `git push`
5. run `git status` and confirm the branch is up to date

## Red Flags

- skipping compounding for meaningful work
- writing vague advice such as "test more carefully"
- inventing findings
- treating missing evidence as optional
- ending the session before `git push` succeeds
