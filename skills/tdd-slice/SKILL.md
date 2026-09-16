---
name: tdd-slice
description: Use when implementing a feature or bugfix with test-first development and you want a disciplined red-green-refactor loop in small vertical slices.
---

# TDD Slice

Write one failing behavior, make it pass with minimal code, then repeat. Tests should verify observable behavior through public interfaces.

## Quick start

- Pick one behavior that matters now.
- Write one failing test for that behavior.
- Implement the smallest change that makes the test pass.
- Re-run the test immediately.
- Stop the slice with explicit proof before expanding scope.

## Workflows

1. Use this skill when:
   - implementing a new feature with clear behavior targets
   - fixing a bug that should gain a regression test
   - changing logic-heavy code where fast feedback matters
2. Do not use it when the environment makes tests impossible and no practical feedback loop exists yet.
3. Choose the highest-value behavior to verify first.
4. Write exactly one failing test for that behavior.
5. Implement the smallest change that makes that test pass.
6. Re-run the relevant test or smallest proving test set.
7. Refactor only after green.
8. End the slice by stating:
   - behavior covered
   - proof run
   - next slice or stop condition

## Hard gate

- Use vertical slices, not horizontal batches of tests.
- Prefer integration-style tests over implementation-coupled tests.
- Do not add speculative behavior for future tests.
- Name tests in the project's domain language when available.
- Do not call the slice complete without one failing-then-passing proof.

## Further reading

- `../plan-griller/SKILL.md` - use first when the change is too ambiguous to choose the next test safely
- `../diagnose-loop/SKILL.md` - use when the test or runtime behavior is failing for reasons you cannot yet explain
