# Category Skeletons

Full body skeleton per category, plus the rule for adding a new one. Core
rules (path, header, citation, table/bullet/prose, sentence style, five
habits) apply on top of everything below -- see `references/core-rules.md`.

## Choosing a category

Ask what kind of knowledge the note holds before writing:

- Explanation of "why", grounded in external sources -> `01_research`.
- Reference-style explanation of a concept, for later lookup -> `03_notes`.
- Record of a decision made, with tradeoffs -> `02_decisions`.
- Record of a resolved problem, told chronologically -> `04_debug-logs`.

## `02_decisions` -- ADR-based

Source: Michael Nygard's Architecture Decision Record format
([reference](https://github.com/joelparkerhenderson/architecture-decision-record/blob/main/locales/en/templates/decision-record-template-by-michael-nygard/index.md)).

One file can hold several numbered decisions. Per decision:

- **Title** -- short noun phrase, as a numbered `## N. <title>` heading.
- **Status** -- `Proposed` / `Accepted` / `Implemented (yyyy-mm-dd)` /
  `Superseded by <link>`.
- **Context** -- the forces/constraints at play, written neutrally. State
  what made this a real decision, not a cosmetic explanation of the obvious
  choice.
- **Decision** -- what was actually decided.
- **Consequences** -- tradeoffs accepted, what this rules out, what it
  unblocks.

Keep a running "Still to do" list at the end of the file (habit 2:
strikethrough completed items instead of deleting them).

## `04_debug-logs` -- postmortem-lite

Source: adapted from the Google SRE postmortem structure (Summary, Impact,
Root cause, Resolution, Timeline).

- **Header** -- `**Summary:**` (what broke, one line) and `**Impact:**`
  (what was blocked, for how long) before any fix detail. Without this, a
  reader has to read the whole numbered log just to know what happened.
- **Body** -- numbered, chronological. Each entry: symptom -> root cause
  (cited per core rule 3) -> fix (exact command or patch, not a paraphrase).
- **Close** with the verified working end-state -- proof the fix actually
  worked (e.g. real command output), not just "fixed".

## `01_research` -- citation-heavy explanation

- Open with an overview table when the note spans multiple sub-topics or
  steps (what's in scope, what's explicitly out of scope).
- Body sections mirror the real structure of what's being researched
  (pipeline steps, a paper's own sections) -- do not bucket into artificial
  "Formulas" / "Findings" sections that break the reasoning chain.
- Every claim tagged per core rule 3.
- If this note rewrites a previous one, close with a "Why this file was
  rewritten" section stating exactly what was wrong or missing before --
  not a vague "improved version".

## `03_notes` -- concept reference

- Opens with one line stating this is recall material -- not a decision,
  not a research claim needing heavy citation.
- Body is mostly definition/explanation tables (term -> meaning). Citation
  is optional for well-known definitions; core rule 3 still applies to any
  non-obvious claim mixed in.

## Creating a new category

Only when none of the four above fit the content. Before adding
`tmp/xx_new-name/`:

1. Name which kind of knowledge it serves (see "Choosing a category" above)
   and state explicitly why the four existing categories don't cover it.
2. Reuse core rules 1-6 unchanged -- only the body skeleton is new content.
3. Pick the next unused two-digit prefix.
