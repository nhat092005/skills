---
name: tdd-slice
description: Use when implementing a feature or bugfix with test-first development and you want a disciplined red-green-refactor loop in small vertical slices.
---

# TDD Slice

## Overview
Write one failing behavior, make it pass with minimal code, then repeat. Tests should verify observable behavior through public interfaces.

## When to Use

- New feature with clear behavior targets.
- Bugfix that should gain a regression test.
- Logic-heavy code where fast feedback matters.

Do not use when the environment makes tests impossible and no practical feedback loop exists yet.

## Workflow

1. Choose the most important behavior to verify first.
2. Write one failing test for that behavior.
3. Implement the smallest change that makes it pass.
4. Re-run the test.
5. Move to the next behavior.
6. Refactor only after green.

## Rules

- Use vertical slices, not horizontal batches of tests.
- Prefer integration-style tests over implementation-coupled tests.
- Do not add speculative behavior for future tests.
- Name tests in the project's domain language when available.
