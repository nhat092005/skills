---
name: write-tmp
description: Write and structure temporary working notes under a tmp/-style directory as standardized markdown -- decision logs (ADR-based), debug logs (postmortem-lite), research notes (citation-heavy), and concept notes -- with consistent metadata headers, source-citation tagging, and table/list/prose rules. Use when the user asks to write, create, or update a note in tmp/, a decision log, a debug log, a research note, a "ghi chú tạm", "note tmp", "quyết định kỹ thuật", "nhật ký debug", or mentions "write-tmp".
---

# Write Tmp

Write working notes that stay useful months later, without inventing a new
shape every time. Every rule here was reverse-engineered from real notes
that already worked, not designed from scratch.

## Output language

Default: Vietnamese, full diacritics.

## Quick start

1. Pick the category with the routing table below. If none fit, read
   "Creating a new category" in `references/category-skeletons.md` first --
   do not invent a folder name on the spot.
2. Build the path: `tmp/<xx_category>/<yyyy-mm-dd>_<kebab-case-slug>.md`.
3. Copy the matching file from `templates/` and fill every placeholder with
   concrete detail -- no vague filler like "tested and works".
4. Apply the rules in `references/core-rules.md` before presenting the note
   as done: metadata header labels, `[source:...]` / `[unverified]`
   tagging on every claim, the table-vs-bullet-vs-prose rule, sentence
   style, and the five writing habits.
5. If appending to an existing file, match its established shape first --
   do not refactor unrelated content while adding new material.

## Category routing

Decide by asking what kind of knowledge the note holds (a Diátaxis-style
filter: explanation vs reference vs decision-record vs incident-record):

| Content is about...                                      | Category (`xx_name`) | Skeleton |
|---|---|---|
| A decision made, with tradeoffs and an evidence trail     | `02_decisions`   | ADR: Status, Context, Decision, Consequences |
| A resolved problem, told chronologically                  | `04_debug-logs`  | Summary/Impact header + numbered Problem->Cause->Fix |
| A claim researched from external sources (papers, docs)   | `01_research`    | Overview table + cited sections |
| A concept or mechanism explained for later recall         | `03_notes`       | Definition table(s), light citation |

Full skeletons, field definitions, and the new-category rule are in
`references/category-skeletons.md`.

## Core rules (summary)

- **Path/name:** `tmp/<xx_category>/<yyyy-mm-dd>_<kebab-case-slug>.md`.
- **Header:** H1 + bold-label metadata lines under it (no YAML frontmatter).
- **Citation:** every non-obvious claim gets `[source: <path>]` or
  `[unverified]` -- in every category, not just research.
- **Table vs bullet vs prose vs tree:** table for >=2 comparable dimensions,
  bullets for discrete unrelated items, prose for causal reasoning, ASCII
  tree (`├──`/`└──`/`│`) for any directory/file layout.
- **Sentences:** active voice, present tense, one claim per sentence, define
  a term on first use then use it bare.
- **Five habits:** inline correction tags, strikethrough on done todo items,
  cross-link when content moves to another file, split the file when it
  starts mixing categories, cite instead of duplicating content.

Full detail, rationale, and sourcing for each rule: `references/core-rules.md`.

## Further reading

- `references/core-rules.md` -- full metadata/citation/table/sentence/habit rules, with sourcing
- `references/category-skeletons.md` -- full skeleton per category + new-category rule
- `templates/decision.md`, `templates/debug-log.md`, `templates/research.md`, `templates/notes.md` -- ready-to-fill starting points
