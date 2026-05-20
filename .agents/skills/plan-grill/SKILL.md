---
name: plan-grill
description: Use when a request is ambiguous, high-risk, or could be implemented in multiple ways, before making code changes or locking a plan.
---

# Plan Grill

## Overview
Use this skill to remove ambiguity before implementation. The goal is to lock scope, assumptions, and verification targets early.

## When to Use

- Requirements are underspecified or overloaded.
- A request touches contracts, data shape, auth, migrations, or external systems.
- Multiple valid implementations exist and the tradeoff matters.

Do not use when the task is tiny and local with obvious verification.

## Workflow

1. Restate the task in concrete terms.
2. Identify assumptions and conflicting interpretations.
3. Check code, docs, tests, and runtime evidence before asking questions that can be answered locally.
4. Ask only the unresolved questions.
5. End with a short implementation target:
   - scope
   - non-goals
   - verification steps

## Rules

- Prefer one sharp question over a long questionnaire.
- Surface the recommended option when tradeoffs are real.
- Do not start coding until the risky ambiguity is resolved.
