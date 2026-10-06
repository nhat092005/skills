---
name: diagnose-bug
description: Use when a bug, flaky test, unexpected runtime behavior, or contradiction between code and observed output needs disciplined debugging before fixing.
---

# Diagnose Bug

## Overview

Debug with evidence, not optimism. The fix should follow a reproduced failure and a tested hypothesis.

## When to Use

- A test fails or flakes.
- Logs and behavior contradict expectations.
- A previous fix did not hold.
- The root cause is unknown.

## Workflow

1. Build the smallest feedback loop that makes the bug visible.
   Improve it until it is fast enough and deterministic enough to trust.
2. Reproduce the failure and record the exact symptom.
   Gate: name one command you already ran that is red-capable (asserts this exact symptom), deterministic, fast, and runnable unattended. No such command, no hypotheses.
3. Narrow the scope: input, environment, component, or commit range.
4. List 2-3 plausible hypotheses, then test one at a time.
   Show the ranked list to the user before testing when that checkpoint is cheap.
5. Add the smallest useful instrumentation.
6. Confirm or kill the hypothesis with evidence.
7. Apply the narrowest fix that matches the proven cause. Grep every caller and fix once at the shared point, not at the symptom.
8. Add a regression test when there is a reliable seam; otherwise rerun the feedback loop and document the missing seam.

## Rules

- Redact secrets (tokens, passwords, auth headers) as `<REDACTED>` before showing commands, output, or captured artifacts.
- Do not patch first and explain later.
- Do not keep multiple active hypotheses in flight.
- Change one variable at a time when instrumenting.
- Tag temporary debug instrumentation with a unique prefix so cleanup is mechanical.
- Prefer checking real contracts, test fixtures, and runtime state over guesswork.
- If the bug is flaky, first improve the feedback loop before changing code.
- Aim to raise reproduction rate, not necessarily to reach 100%.
- If reproduction is impossible, state the missing evidence clearly.
- Before done, remove temporary instrumentation and rerun the original repro.
