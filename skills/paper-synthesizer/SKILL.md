---
name: paper-synthesizer
description: Distill an existing paper note (docs/_notes/) into a per-paper core-value summary, then weave it into a topic-level synthesis with an RK3588-applicability section. Use when the user asks to "chắt lọc"/distill a paper into outputs/, update outputs/<topic>/_synthesis.md, or extract the core value of a paper already noted in _notes/.
---

# Paper Output Synthesizer

Two-layer distillation that sits on top of `_notes/` (the full per-paper notes
written by `paper-note`). This skill does NOT replace `_notes/` and
does NOT re-derive a full note from the PDF — it condenses what already
exists in `_notes/` into two much shorter artifacts:

1. **Core-value file** — one per paper, fixed 6-field checklist.
2. **`_synthesis.md`** — one per topic, weaves all core-value files in that
   topic into a topic-appropriate analytical framework, and always ends with
   a fixed RK3588-applicability section.

Read `references/format-rules.md` before writing either file.

## Output language

Same as `_notes/`: Vietnamese, full diacritics. Proper nouns/technical terms
stay in original form.

## Source of truth

Accuracy is priority #1: every number that appears in a core-value file or
`_synthesis.md` must be verified against the source PDF before it's
written, not just the ones headed for the RK3588 "Applicable" bullets.

- **Primary source: `docs/_notes/<topic>/<paper>.md`** — read this first,
  always, for everything that isn't a number (problem framing, approach,
  limitations).
- **Open the PDF (`docs/papers/<topic>/<paper>.pdf`) to verify every
  number** before it's written into a core-value file or `_synthesis.md`.
  Do not carry a number over from `_notes/` unverified.
- A verified number gets an inline mark: `21 TOPS ✓p.5` (checkmark + PDF page
  it was confirmed on). Every number in the output must carry this mark --
  a number with no mark means it hasn't been checked yet.

## File layout

```
docs/outputs/<topic>/<paper-name>.md   # core-value file, 1 per paper
docs/outputs/<topic>/_synthesis.md     # topic-level synthesis, 1 per topic
```

The `_` prefix keeps `_synthesis.md` sorting first in a directory listing.

## Workflow

1. **Core-value file** (see format-rules.md §1 for the template):
   - Confirm `docs/_notes/<topic>/<paper>.md` exists. If not, stop — this
     skill distills an existing note, it does not write one (that's
     `paper-note`'s job).
   - Fill the 6-field checklist from the note, verifying every number
     against the PDF per the rule above.
   - If `docs/outputs/<topic>/<paper-name>.md` already exists, stop and ask
     the user before overwriting -- do not silently replace an existing
     core-value file.
   - Save to `docs/outputs/<topic>/<paper-name>.md` (same filename as the
     note/PDF).

2. **`_synthesis.md`** (see format-rules.md §2):
   - If `docs/outputs/<topic>/_synthesis.md` does not exist yet: read every
     core-value file currently in the topic, pick an analytical framework
     that actually fits what those papers have in common (do not default to
     any framework from another topic), write the file.
   - If it already exists and you're adding a newly-written core-value file
     to the same topic: **default to patching** — add the new paper's
     content into the existing framework's structure, and extend the RK3588
     section if it adds new applicable/non-applicable items.
   - **Before patching**, check whether the existing framework still
     honestly describes all papers in the topic (old + new). If forcing the
     new paper into it would distort the framework, stop and ask the user
     whether to patch anyway or rewrite `_synthesis.md` from all core-value
     files in the topic. Never silently rewrite — core-value files are never
     lost either way, only the synthesis prose is regenerated.

## Conciseness

Same discipline as `_notes/`: every sentence must add a fact or reasoning
link not stated elsewhere in the same file. Length targets in
format-rules.md are guidance, not hard walls — they flex with how much a
paper actually has to say, but "flexing" must be justified by real content,
not narration.
