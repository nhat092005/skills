---
name: context-glossary
description: Use when a repository has overloaded terminology, inconsistent naming, or repeated jargon confusion and needs a shared glossary without mixing in implementation details.
---

# Context Glossary

## Overview
Use `CONTEXT.md` as a domain glossary. Its job is to define canonical terms and resolve ambiguity. It is not a spec, design log, or implementation notebook.

## When to Use

- The same concept is named three different ways.
- User language and code language drift apart.
- Reviews keep getting stuck on unclear terms.
- A plan depends on precise domain boundaries.

Do not use for low-level implementation decisions. Those belong in code, tests, or ADRs.

## Workflow

1. Look for an existing `CONTEXT.md`.
2. Extract repeated or overloaded domain terms.
3. Propose one canonical term per concept.
4. Record:
   - term
   - concise meaning
   - avoid/ambiguous synonyms when useful
   - key relationships only
5. Update the glossary when terminology is resolved, not in a large batch later.

## Rules

- Keep entries short and domain-focused.
- No implementation details.
- No task tracking, TODOs, or design churn notes.
- If a decision is hard to reverse and needs rationale, use an ADR instead.
