# Core Rules for tmp/ Notes

Applies to every file in `tmp/`, regardless of category. Category-specific
additions live in `references/category-skeletons.md`.

## 1. File path and naming

`tmp/<xx_category>/<yyyy-mm-dd>_<kebab-case-slug>.md`

- `xx_category`: two-digit prefix + short category name (e.g. `02_decisions`).
- Filename: ISO date (the date written, or the date of the event being
  logged for debug-logs) + underscore + kebab-case slug.
- No snake_case, no spaces, no diacritics in the slug itself, even when the
  file's prose content is written in another language (see the Output
  language section in SKILL.md).

Example: `tmp/04_debug-logs/2026-09-18_board-bringup-log.md`

## 2. Metadata header

Directly under the H1 title, before the first `---`, one bold-label line
per fact. No YAML frontmatter -- these are quick working notes, not data
consumed by tooling, and frontmatter syntax is overhead nobody reads back.

Standard labels (use what applies, skip what doesn't). Write the label text
in the note's output language (see SKILL.md); the English forms below name
the concept, not a fixed literal string:

- **Written on:** -- date written.
- **Related to / Supersedes:** -- link to a file this note supersedes or
  depends on.
- **Status:** -- for decisions/debug-logs, whether resolved/executed.

Category skeletons may add their own labels on top of this (e.g. an ADR's
`Status` field is a body field, not a duplicate of this header line).

## 3. Citation / verification tagging (mandatory, every category)

Every non-obvious claim carries one of:

- `[source: <file or doc path>]` -- traceable to a real source (code, a
  vendor doc, a paper note, a command's actual output).
- `[unverified]` -- flagged explicitly as unverified reasoning, not
  presented as settled fact.

Never state a claim as certain without one of these two tags. This applies
even in `03_notes`, where most content is well-known definitions that don't
need it -- but any non-obvious claim inside a notes file still needs one.

When writing in a language other than English, translate the tag text
consistently and reuse the exact same wording across every note in that
language -- don't vary the phrasing from file to file.

## 4. Table vs bullet vs prose vs tree

- **Table** -- when the data has 2+ comparable dimensions (rows x columns
  of attributes: multiple items, each with multiple named attributes).
- **Bullet list (`-`)** -- discrete items with nothing to compare across
  them (a todo list, a list of sources, a list of files touched).
- **Prose paragraph** -- causal reasoning, "why" explanations. Forcing this
  into a table or bullet list breaks the chain from cause to effect.
- **ASCII tree** (`├──`, `└──`, `│`) -- any time the content is a directory
  or file layout. Nested bullets hide which item is nested under which;
  a tree shows the hierarchy at a glance. One-line comment per entry is
  fine (`# what it's for`), a full paragraph per entry is not -- put that
  explanation in prose right after the tree instead.

## 5. Sentence-level style

Adapted from the Google developer documentation style guide, dropping the
second-person recommendation -- these are working notes addressed to the
author's future self, not user-facing instructions.

- Active voice, present tense.
- One claim per sentence. Split any sentence that needs two "which" /
  "in order to" / "so that" clauses.
- Define a technical term or acronym on first use in the file, then use it
  bare for the rest of the file.
- No filler transitions ("as we can see", "it should be noted that",
  "it is worth mentioning").

Source: [Google developer documentation style guide](https://developers.google.com/style/highlights).

## 6. Five writing habits

1. **Inline correction, not silent deletion.** When something previously
   written turns out wrong, add a `**Correction (yyyy-mm-dd):** ...` note
   at the spot instead of deleting it -- the trail of what changed and why
   is worth more than a clean-looking file.
2. **Status with strikethrough.** In a running todo/status list, mark
   finished items `~~item~~ -- DONE` instead of removing them from the list.
3. **Cross-link on split.** When content moves to another file, leave the
   new file's path at the old location. Don't make the reader search.
4. **Split when bloated.** A file that starts mixing research + decision +
   debug content should split along the four categories -- one file per
   concern, not one file carrying all three.
5. **No duplication.** Cite another file's path instead of copying its
   content in. A stale copy is worse than a link.
