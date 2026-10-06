---
name: paper-note
description: Convert an academic paper (PDF or text) into a structured markdown note that preserves the paper's original argument flow. Use when the user asks to summarize, note down, or take notes on a research paper / academic paper, create a .md file from a PDF paper, or wants a "paper note" / "reading note" for later reference.
---

# Paper Note Writer

Turn one paper into one markdown note the reader can rely on without
reopening the PDF, while still able to jump back to the exact page/section.

## Accuracy

Every claim, number, or interpretation in the note must trace to a specific
page/section in the source PDF, using the existing inline page-ref
convention (e.g. "Eq.3, p.5", "Table 2, p.8"). Never add a claim the paper
doesn't make, and never guess a number -- if a value is illegible or
missing, say so instead of estimating it.

## Output language

Default: Vietnamese, full diacritics (never strip tone marks). User can override,
e.g. "write in English". Keep proper nouns / technical terms in original form.

## Conciseness -- this is what usually goes wrong

Long != thorough. Verbosity happens when the note re-explains things already
said, repeats the same connector phrase for every equation/table/figure, or
narrates in full sentences what a short clause would say. Fix:

- State the point once. Don't restate context the reader already has from
  the paragraph above.
- Don't reuse the same scaffolding phrase ("this is the evidence for...",
  "continuing from...") on every single item -- vary it or cut it, keep only
  the causal link itself, drop the narration around it.
- Prefer short declarative sentences over multi-clause ones. If a sentence
  needs "which," "in order to," "this shows that" twice, split or trim it.
- No summary-of-a-summary. Don't add a closing recap sentence to a
  subsection that just repeats what the subsection already said.
- Every sentence must add new information. If a sentence could be deleted
  without losing a fact or a reasoning link, delete it.



Do NOT bucket content into separate "Formulas" / "Tables" / "Figures"
sections -- that breaks the argument chain (which equation leads to which
claim, which table proves which point). Follow the paper's own section
order and insert every equation/table/figure inline, exactly where it
appears, with a note on why it's there and what it leads to next.

See `references/format-rules.md` for the template, inline-insertion format,
and completion checklist. Read it before writing, and check off the
checklist before presenting the note as done.

## Save path

`docs/_notes/<topic>/<same-filename-as-pdf>.md`

If this file already exists, stop and ask the user before overwriting --
do not silently replace an existing note.
