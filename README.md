# Skills

Personal agent skills. `skills/` is linked to `~/.claude/skills` and `AGENTS.md` to `~/.claude/CLAUDE.md` by `link-setup.sh`.

## Plan and decide

| Skill | Use when |
|---|---|
| `grill-me` | A plan, design, or request is vague or risky and needs to be stress-tested before coding. |
| `grill-with-docs` | Same as `grill-me`, and the project's glossary and ADRs should be updated as decisions settle. |
| `domain-modeling` | Terms are inconsistent, `GLOSSARY.md` needs editing, or a decision may deserve an ADR. |
| `repo-onboarding` | Starting in an unfamiliar repo or resuming after context loss. |

## Write code

| Skill | Use when |
|---|---|
| `tdd` | Building a feature or fixing a bug test-first, in small vertical slices. |
| `diagnose-bug` | A bug, flaky test, or unexpected behavior has an unknown cause. |
| `architecture-check` | A small change may hide coupling or complexity across modules. |
| `ponytail` | Adjusting how strictly the simplicity ladder in `AGENTS.md` applies (`lite`, `full`, `ultra`, `off`). |
| `makefile` | Writing or fixing GNU Make or Kbuild Makefiles. |

## Git and work tracking

| Skill | Use when |
|---|---|
| `commit-prep` | Choosing a commit convention, splitting changes, or writing commit messages. |
| `jira` | Writing a Jira ticket description or comment. |
| `handoff` | Ending a long session and passing the work to a fresh agent. |

## Research and notes

| Skill | Use when |
|---|---|
| `deep-research` | A problem needs an evidence-backed solution, not a first guess. |
| `paper-note` | Turning one academic paper into a structured note. |
| `paper-synthesizer` | Distilling a paper note into a summary and a topic-level synthesis. |
| `write-tmp` | Writing working notes in `tmp/`: decision logs, debug logs, research notes, concept notes. |

## Other

| Skill | Use when |
|---|---|
| `en-vi-tutor` | Understanding English technical text, explained sentence by sentence in Vietnamese. |
| `caveman` | Replies should be as terse as possible to save tokens. |
| `write-a-skill` | Creating a new skill. |
