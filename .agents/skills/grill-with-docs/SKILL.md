---
name: grill-with-docs
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when user wants to stress-test a plan against their project's language and documented decisions.
---

# Grill with docs

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for feedback on each question before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

## Domain awareness

During codebase exploration, also look for existing documentation.

### Determining the feature name

The feature name is used to scope all documentation under `.mnhat/history/<feature>/`.

Resolve it in this order:

1. List existing folders under `.mnhat/history/` — if one matches the plan being discussed, use that name.
2. If multiple folders exist but none clearly matches, ask the user which one applies.
3. If no folders exist yet, ask the user for a short kebab-case feature name before doing anything else.

### File structure

All documentation lives under `.mnhat/history/<feature>/`. Multiple features coexist as sibling folders — no map file needed:

```
.mnhat/
└── history/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── adr/
    │       ├── 0001-<slug>.md
    │       └── 0002-<slug>.md
    └── billing/
        ├── CONTEXT.md
        └── adr/
```

Create files lazily — only when you have something to write. If no `CONTEXT.md` exists for the feature, create one when the first term is resolved. If no `.mnhat/history/<feature>/adr/` exists, create it when the first ADR is needed.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in `.mnhat/history/<feature>/CONTEXT.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account' — do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible — which is right?"

### Update CONTEXT.md inline

When a term is resolved, update `.mnhat/history/<feature>/CONTEXT.md` right there. Don't batch these up — capture them as they happen. Use the format in [CONTEXT-FORMAT.md](references/CONTEXT-FORMAT.md).

`CONTEXT.md` should be totally devoid of implementation details. Do not treat `CONTEXT.md` as a spec, a scratch pad, or a repository for implementation decisions. It is a glossary and nothing else.

### Offer ADRs sparingly

Only offer to create an ADR when all three are true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful
2. **Surprising without context** — a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR. ADR files are written to `.mnhat/history/<feature>/adr/<index>-<slug>.md` using the format in [ADR-FORMAT.md](references/ADR-FORMAT.md). The index is zero-padded to 4 digits and increments from existing files in that folder.
