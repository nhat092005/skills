# Format Rules

Prose (headers, explanations) in the output language set in SKILL.md.
Proper nouns / model / architecture names stay in original form.

## 1. Structure -- mirror the paper's own table of contents

```markdown
# <Paper title>
- **Authors / Organization:**
- **Year / Venue:**
- **Original link:**
- **Local PDF file:**

## Quick index
- **What the paper is about (1 sentence):**
- **Document type:** academic paper | whitepaper | technical report | ...
- **Has Method/Experiments sections:** yes / no (if no, the note won't
  have those two sections either -- don't force them)
- **Main result →** [link to the corresponding heading in the body]
- **Main limitation →** [link to the corresponding heading in the body]

This index is the one fixed, cross-note-comparable part of the note -- it
lets a reader (or the `paper-synthesizer` skill) find what a paper
is about without reading the whole thing. The body below stays free-form,
mirroring the paper's own structure -- never force a paper's argument into
a structure it doesn't have.

## Abstract (paraphrased, not verbatim)

## 1. Introduction
(problem -> why hard -> gap in prior work -> what this paper does)
(keep contributions as bullets if paper lists them that way)

## 2. Related Work / Background
(keep the paper's own grouping of prior approaches, e.g. if it splits
3 dataflow types, note all 3)

## 3. Method / Architecture
### 3.1 <subsection title, same as paper>
(full reasoning chain, in the paper's own order -- see Section 2 below
for equations/figures/tables inside this flow)
### 3.2 ...

## 4. Experiments
### 4.1 Setup (dataset, hardware, baselines)
### 4.2 Results (same order the paper presents them)

## 5. Discussion / Limitations (if present)
## 6. Conclusion

---
## Connection to my project (<current topic>)
(the only section allowed to break from paper order -- this is your
own view, not the paper's)

## New terms
## Open questions (write honestly, don't skip)
```

## 2. Insert equations/figures/tables inline, never bucket them

**Equation**, inside the paragraph being noted:
```markdown
The paper defines latency as (Eq. 3, p.5):
$$ T = T_{compute} + T_{memory} $$
Since $T_{memory} \gg T_{compute}$ for most CNN layers, the paper argues
the main optimization target is memory access -- motivating the
row-stationary dataflow in Section 3.2 below.
```
Always note *why* the equation is there and what it leads to next -- not
just the equation itself.

**Figure**, at the exact paragraph describing it:
```markdown
Figure 4 (p.6) shows the 3-stage pipeline:
![Fig.4](images/<paper-name>/fig4.png)
Stage 1 (input buffering) solves the bottleneck raised in the previous
paragraph -- continuing from Eq. 3 above.
```
Crop figures with `pdftoppm` (from `poppler-utils`/`poppler`). Check
`pdftoppm -v` first; install via the OS package manager if missing
(`apt install poppler-utils` on Debian/Ubuntu, etc.). Don't assume a fixed
install path -- `which pdftoppm` before first use on a new machine, since
the path differs across OS/installs.

**Table**, where the paper uses it to prove a point:
```markdown
Table 2 (p.8) compares 3 dataflows on the same benchmark:
| Dataflow | Energy (nJ) | Latency (ms) |
|---|---|---|
| Weight-stationary | ... | ... |
| Row-stationary (proposed) | ... | ... |
Row-stationary is X% lower in energy -- this is the empirical evidence
for the argument in Eq.3/Fig.4 above.
```
Use a connective phrase so the reasoning link is visible -- but vary the
wording and keep it short. Don't repeat the exact same phrase for every
item; a short clause is enough, not a full sentence of narration.

Verbose (avoid): "This is the empirical evidence that supports the
argument that was made earlier in Eq.3 and Fig.4, which closes the
argument of Section 3.2."
Concise (use): "-- confirms the Eq.3/Fig.4 argument."

## 3. Hard rules

- Never collapse paragraphs that contain a reasoning step (A -> B, B
  challenged by C) into one generic sentence.
- Never relocate an equation/table/figure out of its original reading
  position, even to "group similar things."
- Keep exact numbers -- no rounding, no "significant improvement."
- Every numbered equation in the paper must appear in the note.
- If an equation can't be reproduced in LaTeX, insert a cropped image +
  explain every symbol -- never an image with no explanation.

## 4. Checklist before presenting the note

- [ ] Target file doesn't already exist, or user was asked before overwriting?
- [ ] "Quick index" present with all 5 fields, right after metadata?
- [ ] Follows the paper's own section/subsection order?
- [ ] Every equation/table/figure has a "why it's here / what it leads
      to" note, not a bare copy?
- [ ] No collapsed/skipped reasoning steps?
- [ ] Every numbered equation present?
- [ ] No claim/number added that isn't traceable to a specific page in the
      source PDF?
- [ ] "Connection to my project" is concrete, not generic?
- [ ] Output language: full diacritics/native script used throughout
      (no ASCII-stripped or romanized fallback)?
- [ ] No redundant sentences -- every sentence adds a fact or a reasoning
      link, none just restates what was already said?

## 5. File layout

```
docs/papers/<topic>/<paper-name>.pdf
docs/_notes/<topic>/<paper-name>.md
docs/_notes/<topic>/images/<paper-name>/fig4.png
```
