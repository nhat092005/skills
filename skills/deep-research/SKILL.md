---
name: deep-research
description: Investigate a technical problem through a Design Science Research
  loop (Problem Framing -> Awareness -> Suggestion -> Development -> Evaluation
  -> Conclusion), grounding each phase in evidence and looping until success
  criteria are met or the iteration cap is hit. Use when the user hands off a
  problem that needs "nghiên cứu sâu", "đào kỹ", "tìm giải pháp có căn cứ", or
  wants a solution backed by researched evidence and prior art rather than a
  first guess. Not for summarizing or taking notes on a single paper -- use
  paper-note for that.
---

# Deep Research

## Accuracy first

Every claim made in Suggestion, Development, or Evaluation is either
grounded in step 2 evidence (cite it) or explicitly labeled an assumption --
never state an untested assumption as settled fact. Do not fabricate
sources, numbers, or prior-art claims; if evidence can't be found, say so
instead of guessing.

## Quick start

1. **Problem Framing** -- state the problem, scope, and success criteria in
   one paragraph. Ask the user back only if the scope is genuinely unclear;
   otherwise state the assumption and move on.
2. **Awareness** -- search and read prior art, existing solutions, docs. Prefer primary sources (official docs, source code, specs) over write-ups of them.
   Summarize findings with `[source: ...]` tags inline as you go; do not
   write the final note yet.
3. **Suggestion** -- propose 1-3 candidate directions, each with its
   assumptions stated explicitly.
4. **Development** -- implement, analyze, or simulate the most feasible
   direction.
5. **Evaluation** -- measure the result against the step-1 criteria.
   - Criteria met -> go to step 6.
   - Criteria not met -> return to step 2 or 3 carrying what was learned.
   - After 3 evaluation rounds without meeting criteria, stop looping and
     surface to the user: what was tried, what's still unmet, and ask how to
     proceed. Do not loop a 4th time without explicit user go-ahead.
6. **Conclusion** -- hand off to the `write-tmp` skill, `01_research`
   category, to write the final note: chosen solution, rationale, confidence
   level (High/Medium/Low with why), and the full source list gathered in
   step 2. Follow write-tmp's own language default (Vietnamese) and citation
   rules -- do not invent a separate report format here.

## Example

Problem: "Choose a caching strategy for a read-heavy internal API."

1. Problem Framing: scope = single API, success criteria = p95 latency
   under 50ms at current load, no cache-invalidation bugs on write.
2. Awareness: read existing service docs, current latency metrics, and 2-3
   external write-ups on cache-aside vs read-through patterns, each cited.
3. Suggestion: (a) cache-aside with TTL, (b) read-through with write-behind,
   each with stated assumptions about write frequency.
4. Development: implement (a) behind a flag, since write frequency is low
   per step-2 evidence.
5. Evaluation: measure p95 latency; if it misses target, return to step 3
   with the new data point (e.g. cold-cache penalty) instead of guessing.
6. Conclusion: write-tmp note under `01_research` with the chosen strategy,
   why (b) was rejected, confidence level, and links to the sources read.

## Scope boundary

- A request to summarize, annotate, or take notes on one specific paper is
  paper-note's job, not this skill's -- even if the user says "dao sau" about
  that paper.
- A highly ambiguous request that needs a full ambiguity interview before
  any research starts is out of scope for step 1's one-line check; that
  level of interview belongs to grill-me, but deep-research does not
  invoke it automatically -- step 1 stays a lightweight checkpoint.

## Further reading

- references/methodology.md -- full DSR loop rationale, the write-tmp
  handoff mechanics in detail, and a second worked example showing a
  loop-back round
