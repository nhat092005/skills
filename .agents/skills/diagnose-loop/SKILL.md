---
name: diagnose-loop
description: Use when a bug, flaky test, unexpected runtime behavior, or contradiction between code and observed output needs disciplined debugging before fixing.
---

# Diagnose Loop

## Overview
Debug with evidence, not optimism. The fix should follow a reproduced failure and a tested hypothesis.

## When to Use

- A test fails or flakes.
- Logs and behavior contradict expectations.
- A previous fix did not hold.
- The root cause is unknown.

## Workflow

1. Build the smallest feedback loop that makes the bug visible.
2. Reproduce the failure and record the exact symptom.
3. Narrow the scope: input, environment, component, or commit range.
4. Form one hypothesis at a time.
5. Add the smallest useful instrumentation.
6. Confirm or kill the hypothesis with evidence.
7. Apply the narrowest fix that matches the proven cause.
8. Add or run regression verification.

## Rules

- Do not patch first and explain later.
- Do not keep multiple active hypotheses in flight.
- Change one variable at a time when instrumenting.
- Tag temporary debug instrumentation with a unique prefix so cleanup is mechanical.
- Prefer checking real contracts, test fixtures, and runtime state over guesswork.
- If the bug is flaky, first improve the feedback loop before changing code.
- If reproduction is impossible, state the missing evidence clearly.
