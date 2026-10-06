---
name: domain-modeling
description: Build and sharpen a project's domain language. Use when discussing terminology, writing or editing GLOSSARY.md, or deciding whether a decision deserves an ADR.
---

# Domain Modeling

Keep one name per concept. While designing, actively challenge terms and write the glossary down the moment a term is settled. Merely reading `GLOSSARY.md` for vocabulary is not this skill.

## Files (in the project repo, never in tmp/)

- `GLOSSARY.md` at the repo root. If `GLOSSARY-MAP.md` exists, the repo has several contexts, each with its own `GLOSSARY.md`.
- `docs/adr/NNNN-slug.md`, numbered by the highest existing number plus one.
- Create each file lazily, only when there is something to write.

## During the session

- Term conflicts with the glossary: call it out and ask which meaning is intended.
- Vague or overloaded term: propose one canonical name.
- Invent concrete edge-case scenarios to force precise boundaries between concepts.
- If the code disagrees with what the user says, surface the contradiction.
- Update `GLOSSARY.md` immediately when a term is settled, not in a batch.

## GLOSSARY.md format

```md
# <Context name>

<One or two sentences on what this context is.>

## Language

**Order**:
<One or two sentences: what it IS.>
_Avoid_: Purchase, transaction
```

- Be opinionated: pick one word, list the rest under `_Avoid_`.
- Only project-specific terms. No general programming concepts, no implementation details.

## ADR

Offer an ADR only when all three hold: hard to reverse, surprising without context, the result of a real trade-off. Otherwise skip it.

Format: a title, then 1-3 sentences on context, decision, and why. Optional `Status`, `Considered Options`, `Consequences` only when they add value.

Long evidence trails and analysis belong in a `write-tmp` decision log, which can link to the ADR.

Idea from github.com/mattpocock/skills.
