---
name: debugging
description: Use when blocked workers, test failures, build errors, runtime crashes, or integration issues need systematic root-cause debugging. Follow an evidence-first loop, use current `bd` context, and leave reusable outcomes for compounding.
---

# Debugging

Resolve blockers and failures systematically. Do not guess. Triage first, reproduce second, diagnose third, fix fourth.

Use `diagnose-loop` when the root cause is unclear or the failure needs a tighter feedback loop before code changes.

## When To Use This Skill

- a build fails
- a test fails
- a runtime crash or exception occurs
- an integration breaks
- a worker is blocked by dependencies, scope, or failing verification
- reviewing or executing hands off with a failure that needs root-cause analysis

---

## Step 1: Triage

Classify the issue before you investigate it.

| Type | Signals |
|---|---|
| Build failure | compiler error, type error, missing module, bundler failure |
| Test failure | assertion mismatch, timeout, snapshot diff, flake |
| Runtime error | crash, uncaught exception, undefined behavior |
| Integration failure | HTTP 4xx/5xx, auth failure, env mismatch, schema mismatch |
| Worker blocker | blocked `bd` dependency, overlapping worker scope, or no safe execution path |

Output a one-line classification:

`[TYPE] in [component]: [symptom]`

---

## Step 2: Reproduce

Check the active `bd` item and any relevant `bd remember` notes first. If a matching pattern already exists, start from that evidence.

Then rerun the exact failing command and capture the exact output.

Examples:

```bash
npm run build 2>&1 | tee /tmp/debug-output.txt
pytest tests/specific_test.py -v 2>&1 | tee /tmp/debug-output.txt
```

Run it twice. If it is intermittent, treat it as a flaky failure rather than a deterministic one.

---

## Step 3: Diagnose

Work through these checks in order.

### 3a. Read the relevant files

Use the failing output to identify the smallest relevant slice. Do not read the entire repo.

### 3b. Check recent changes

```bash
git log --oneline -20
git blame <file> -L <line>,<line>
git diff HEAD~3 -- <file>
```

### 3c. Check tracked intent

Ask whether the code drifted from the current `bd` item, or the tracked expectation itself is wrong.

### 3d. Check locked decisions

Read the relevant `CONTEXT.md` entries and confirm the implementation did not violate a locked decision.

### 3e. Check current worker or handoff state

If this debugging pass came from `swarming`, use the parent thread, the active slice assignment, and any `.mnhat/swarming/HANDOFF.json` or `.mnhat/session/HANDOFF.json` artifact. Do not invent a second coordination channel.

### 3g. Write the root cause sentence

Do not proceed until you can write:

> Root cause: `<file>:<line>` — `<what is wrong and why>`

If you cannot write that sentence, you do not have the root cause yet.

---

## Step 4: Fix And Verify

### Small fix

If the fix is obvious and low risk:

- implement directly
- run the exact failing command again
- run the next-wider verification that protects against regressions

### Larger fix

If the fix is cross-cutting or changes the intended behavior:

create or update a `bd` item for the fix before expanding scope.

### Decision violation

If a locked decision was violated:

- do not silently "fix" it by changing behavior on your own
- return or report a blocker summary to the parent thread or user
- propose the conservative fix that honors `CONTEXT.md`

### Verify

The original failing command must pass cleanly. If it still fails, return to diagnosis.

---

## Step 5: Report

If you are inside a swarm, return the debugging result to the parent thread using a clear status heading:

- `[DONE]` if the fix is complete and verified
- `[BLOCKED]` if the problem needs a decision, a dependency to clear, or a broader redesign

At minimum include:

- root cause sentence
- fix summary
- verification result
- relevant `bd` or handoff impact, if any
- next action needed

If you are working directly for the user, give the same information in the final response.

---

## Step 6: Learn

If this exposed a new reusable failure pattern, leave a concrete note for `compounding` so it can be captured with `bd remember`.

If the failure matched an existing `bd remember` lesson, verify whether that guidance still works. If not, flag it for compounding.

---

## Blocker-Specific Protocol

When a worker is stuck rather than code-broken:

1. inspect the active `bd` dependency or current-work boundary
2. inspect the worker assignment or handoff artifact
3. determine whether the worker is:
   - waiting on another `bd` item
   - blocked by overlapping scope
   - blocked by a real product decision

If it is only waiting, return `[BLOCKED]` with the blocking dependency or active owner and stop.

If it is a real dead-end, return `[BLOCKED]` with concrete options for the parent or user.

Do not spin.

---

## Red Flags

- fixing symptoms instead of root cause
- skipping reproduction
- ignoring relevant `bd` context or prior lessons
- patching around a locked decision violation
- reporting success without rerunning the original failing command
- forgetting to account for active worker scope during swarm debugging

---

## Quick Reference

| Situation | First action |
|---|---|
| Build fails | rerun the exact build command |
| Test fails | rerun the exact test and capture assertion output |
| Runtime crash | read the stack trace and find the first line in your code |
| Integration error | check env/config, then the real response body |
| Worker stuck | inspect the assigned slice, `bd` dependency, and active handoff |
| Recurring issue | check relevant `bd remember` notes first |
