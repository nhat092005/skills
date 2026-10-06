# Deep Research Methodology

Deep reference for the deep-research skill: why the loop is shaped this way,
how the write-tmp handoff works in detail, and a second worked example that
shows a loop-back round.

## Table of contents

1. Why Design Science Research
2. Why the 3-round iteration cap
3. The write-tmp handoff, in detail
4. Worked example with a loop-back round

---

## 1. Why Design Science Research

Design Science Research (Hevner et al.) treats a technical problem as an
artifact to be built and evaluated against explicit criteria, not a question
answered from memory. The loop structure exists to stop two common failure
modes:

- Jumping straight to Development without stating what "done" means
  (Problem Framing exists to prevent this).
- Treating the first plausible answer as final without checking it against
  prior art or measuring it (Awareness and Evaluation exist to prevent this).

Each phase produces a concrete artifact (problem statement, cited summary,
candidate list, implementation, measurement, note) so the loop can be
resumed or audited later even if interrupted.

## 2. Why the 3-round iteration cap

Without a cap, step 5's loop-back has no natural stopping point and can
burn arbitrary context on a dead-end direction. 3 rounds mirrors the
hypothesis-count guidance in `diagnose-bug` (2-3 hypotheses before
escalating) -- enough for one wrong Suggestion to get corrected once, tight
enough that a genuine dead end surfaces to the user quickly instead of
silently consuming the session.

When the cap is hit, report state honestly: what was tried in each round,
what the Evaluation step measured, and what specifically is still unmet.
Do not present a failed direction as a finished Conclusion.

## 3. The write-tmp handoff, in detail

Conclusion does not write a report directly. It calls the `write-tmp`
skill with category `01_research` (per write-tmp's own routing table:
"A claim researched from external sources (papers, docs)").

Map deep-research's artifacts onto write-tmp's research template like this:

| deep-research artifact                         | write-tmp research note field        |
|------------------------------------------------|--------------------------------------|
| Step 1 problem statement                       | note's framing / context section     |
| Step 2 cited findings (`[source: ...]` tags)   | cited sections, carried over verbatim|
| Step 3 candidate directions + assumptions      | alternatives considered              |
| Step 5 measurement against criteria            | evidence backing the conclusion      |
| Step 6 chosen solution + confidence level      | the note's conclusion / claim        |

Do not re-derive citation formatting rules here -- write-tmp's
`references/core-rules.md` already owns `[source:...]` / `[unverified]`
tagging, table-vs-bullet rules, and sentence style. Follow that file, not a
parallel convention invented in this skill.

write-tmp defaults note language to Vietnamese; deep-research does not
override this, so the final note is Vietnamese even though this skill's own
instructions are in English.

## 4. Worked example with a loop-back round

Problem: "Should we migrate the internal notification service from REST to
gRPC?"

1. **Problem Framing** -- scope = one internal service, two known callers.
   Success criteria: p99 latency improves by >=20%, and both callers can
   migrate within one sprint.
2. **Awareness** -- read the service's current API docs, the two callers'
   client code, and 2 external write-ups comparing REST/gRPC overhead for
   small payloads, each cited.
3. **Suggestion** -- (a) full gRPC migration, (b) gRPC only for the
   highest-traffic caller, keeping REST for the other. Assumption for (a):
   both callers can adopt a gRPC client within a sprint.
4. **Development** -- implement (a) behind a feature flag, since it's the
   simpler artifact to measure first.
5. **Evaluation, round 1** -- latency improves 22% (criteria met) but one
   caller's client library has no mature gRPC support, so it cannot migrate
   within a sprint (criteria not met). Loop back to step 3 with this new
   constraint.
6. **Suggestion, round 2** -- revise to option (b): gRPC only for the
   caller whose client library supports it; the other stays on REST.
7. **Development, round 2** -- implement (b).
8. **Evaluation, round 2** -- latency target met for the migrated caller,
   both callers ship within the sprint. Criteria met -> proceed to
   Conclusion.
9. **Conclusion** -- write-tmp note under `01_research`: chosen solution
   (b), rationale (client library constraint ruled out (a)), confidence
   High (measured, not projected), sources from step 2.

This shows the cap in action: round 1 failed on one criterion, round 2
succeeded, so the loop closed at 2 rounds -- well under the 3-round cap.
