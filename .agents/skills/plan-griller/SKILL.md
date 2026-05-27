---
name: plan-griller
description: Use when a request is ambiguous, high-risk, or plausibly implementable in multiple valid ways, before making code changes or locking an execution plan.
---

# Plan Griller

## Quick start

- Restate the request in concrete implementation terms.
- Inspect code, docs, tests, and runtime evidence before asking anything discoverable locally.
- Ask exactly one unresolved question at a time.
- For each question, give your recommended answer and why.
- Stop once the work has a bounded implementation target.

## Workflows

1. Classify the ambiguity:
   - unclear scope
   - conflicting interpretations
   - risky contract or data impact
   - multiple valid implementation paths
2. Read the highest-signal local sources before questioning:
   - current code
   - docs or contracts
   - tests
   - logs or runtime evidence
3. Ask only the unresolved highest-leverage question.
4. After each answer, tighten the working target:
   - scope
   - non-goals
   - verification
   - next step
5. Do not start coding until the risky ambiguity is resolved enough for one believable implementation target.

## Hard gate

Do not end the grill until these are clear enough:

- what should change
- what must not change
- how success will be verified
- what next skill or implementation step should happen

If the answer can be proven from the codebase, inspect it instead of asking.

## Further reading

- `../grill-me/SKILL.md` - generic relentless questioning when the user explicitly wants a broad design interview
- `../goal-griller/SKILL.md` - use when the destination is a verifiable `/goal` prompt rather than an implementation target
