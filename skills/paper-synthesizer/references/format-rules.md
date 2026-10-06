# Format Rules

Prose (headers, explanations) in the output language set in SKILL.md
(Vietnamese, full diacritics). This template file itself stays in English,
same convention as `paper-note/references/format-rules.md`.

## 1. Core-value file (`docs/outputs/<topic>/<paper-name>.md`)

### Header

```markdown
# <Paper title> — Core value

- **Source note:** `docs/_notes/<topic>/<paper-name>.md`
- **Source PDF:** `docs/papers/<topic>/<paper-name>.pdf`
- **Date written:** <YYYY-MM-DD>
```

### The 6 fields

```markdown
## 0. Paper type
<1 line: survey | experimental | system/deployment>

## 1. Problem & gap
<~3 sentences: the problem the paper solves, the gap in prior work>

## 2. Core contribution
- <bullet, pulled straight from the paper's own "Contributions" if listed>
- <bullet>
<~5 bullets target — only exceed if the paper genuinely lists that many
independent contributions, not by splitting one idea into several bullets>

## 3. Approach
<~3 sentences: the main mechanism/technique, enough to understand WHY it
works, not a summary of the whole Method section>

## 4. Key evidence
<If experimental/system: the single most important number/result proving
the contribution, ~3 sentences/bullets, verify every number against the PDF
before writing it -- not just numbers headed for `_synthesis.md`.>
<If survey: reframe as "the synthesized picture the survey draws" (its
taxonomy, its grouped list of techniques) + this mandatory caveat sentence:
"Numbers in this section are secondary aggregates the survey pulled from
many different sources, not a result the paper measured itself — do not
compare them across rows as if from the same experiment.">

## 5. Limitations / trade-offs
<~3 sentences: limitations the paper admits, or that show up in its own
results>
```

Length targets above (3 sentences, 5 bullets, ~35 lines for the whole file)
are soft — flex when the paper genuinely has more to say, not as an excuse
to narrate.

## 2. `_synthesis.md` (`docs/outputs/<topic>/_synthesis.md`)

### Header

```markdown
# <Topic name> — Synthesis

- **Core-value files woven in:** <paper1>.md, <paper2>.md, ...
- **Analytical framework in use:** <1 line describing the framework + why
  it fits what these specific papers have in common — don't copy a
  framework from another topic unless it genuinely fits>
- **Last updated:** <YYYY-MM-DD>
```

### Body — topic-specific framework

Free-form, organized around whatever axis actually unifies the papers in
this topic (e.g. dataflow taxonomy for `01_hardware`, PTQ vs QAT for
`02_quantization`, compile pipeline stage for `03_compiler`). Pull content
from the core-value files, not from re-reading `_notes/` or the PDFs. Each
paper's contribution should be traceable to its core-value file.

### Fixed closing section — RK3588 applicability

This section's shape never changes across topics, so it's the one part
that's directly comparable/searchable across all `_synthesis.md` files:

```markdown
---
## RK3588 applicability

### Applicable
- **[Priority: high|medium|low]** <technique/insight> — <why it fits
  RK3588's real constraints (~6 TOPS NPU, RKNN-Toolkit2), source:
  <paper>.md>

### Not applicable / needs adjustment
- <technique> — <why it doesn't fit RK3588's constraints (e.g. needs
  hardware RK3588 doesn't have, assumption doesn't hold for this NPU)>

### Open questions to verify on real hardware
- <question the paper/survey can't answer, only verifiable by testing on
  RK3588 + RKNN-Toolkit2>
```

## 3. Update workflow when a topic gains a new paper

1. Write the new paper's core-value file first (per §1) — independent of
   whether `_synthesis.md` exists yet.
2. If `_synthesis.md` doesn't exist: read all core-value files in the topic,
   pick the framework, write it fresh.
3. If `_synthesis.md` exists: check whether its current framework still
   honestly fits every core-value file in the topic (old + new one). If
   yes, patch — add the new content into the existing structure and extend
   the RK3588 section. If no, stop and ask the user before rewriting the
   whole file from all core-value files in the topic. Core-value files are
   never deleted or rewritten by this step either way.

## 4. Checklist before presenting a core-value file or synthesis update as done

- [ ] Core-value file used `_notes/` for everything except numbers, and
      every number was verified against the PDF?
- [ ] Target core-value file doesn't already exist, or user was asked before
      overwriting?
- [ ] All 6 fields present, field 0 correctly labels the paper type?
- [ ] Field 4 uses the survey-specific caveat sentence if the paper is a survey?
- [ ] Every number carries its `✓p.N` mark (verified against the PDF, not
      inherited from `_notes/` unchecked)?
- [ ] `_synthesis.md` framework description names why it fits this topic's
      papers specifically (not copied from another topic)?
- [ ] RK3588 section present in the exact 3-subsection shape, priority tag
      on every "Applicable" item?
- [ ] If patching, existing framework still honestly covers the new paper —
      if not, user was asked before any rewrite?
- [ ] No redundant sentences — every sentence adds a fact or reasoning link?
