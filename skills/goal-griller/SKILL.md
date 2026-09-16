---
name: goal-griller
description: Use when the user wants to turn a rough idea, vague task, feature wish, or bug-fix intent into a clear, evaluator-checkable condition for Claude Code's `/goal` command. Use when the user mentions goal mode, `/goal`, long-running or autonomous work, or asks to be interviewed/grilled before setting a goal.
metadata:
  dependencies: []
---

# Goal Griller

Interrogate fuzzy intent until it becomes a goal condition Claude Code's `/goal` command can check after every turn — and a kickoff prompt Claude can actually act on. This skill is inspired by the `grill-me` pattern: ask one question at a time, recommend an answer, and inspect the codebase instead of asking when the answer is discoverable.

## How `/goal` actually works

`/goal <condition>` (up to 4000 chars) sets a completion condition. After every turn, a separate small-model evaluator reads the condition plus the full conversation transcript and decides "met" or "not met" — it has no tools of its own, so it can only judge what Claude's own turns have visibly demonstrated (command output, test results, diffs shown, etc.), not silently re-check the filesystem or rerun anything.

Consequences that shape how a goal must be drafted:

- The condition must be something provable *from what Claude shows in the transcript*. "All tests pass" only works if Claude actually runs the tests and the output appears in a turn.
- `/goal` alone does not give Claude the task — it only sets the stop condition. The task itself still has to be given as a normal instruction (the "kickoff prompt" below).
- One goal per session; a new `/goal` replaces the active one. `/goal` with no args shows status. `/goal clear` (aliases `stop`, `off`, `reset`, `none`, `cancel`) removes it.
- The goal is in-memory and session-scoped: `/clear` removes it; `--resume`/`--continue` restores it only if it was still active (not yet met, not cleared) when the session ended.
- Works with auto mode (fewer per-tool prompts) and non-interactive mode (`claude -p "..." --stream-json --verbose`) for less-supervised runs.
- `/goal` is built on a session-scoped hook internally — it will not function if the environment has `disableAllHooks` or `allowManagedHooksOnly` set.

## Hard Gate

Do not produce a final goal condition until these fields are clear enough:

1. Outcome: the single truth the user wants made real.
2. Success condition: something the evaluator can confirm purely from the transcript — Claude will need to actually produce/show this proof each turn (test output, build result, diff, etc.), not just claim it.
3. Scope boundary: what may change and what must not change.
4. Context: files, docs, logs, issues, screenshots, services, or commands Claude should read first.
5. Verification loop: what Claude should re-run each iteration so the proof is visible in the transcript when it's actually true.
6. Stop and pause rules: when to treat it as done, and when to pause for human input instead of guessing.

If any field is missing, ask the next highest-leverage question instead of drafting the final goal.

## Interview Loop

1. Restate the apparent intent in one sentence.
2. Identify the weakest missing field from the hard gate.
3. If the answer can be discovered from local files, active goal state, logs, docs, tests, or repo conventions, inspect those sources instead of asking.
4. Ask exactly one question at a time.
5. For each question, include your recommended answer and why it is probably right.
6. After the user answers, update the working goal shape and repeat.

The interview should feel useful, not bureaucratic. Prefer three sharp questions over ten generic ones. Stop interviewing as soon as the goal is safely draftable.

## Question Priority

Ask in this order unless local context shows a different blocker:

1. What should be true at the end?
2. How will Claude demonstrate that in its own output, so the `/goal` evaluator can see it?
3. What is explicitly out of scope?
4. What should Claude read or preserve before acting?
5. What should Claude re-run each turn so the proof stays visible?
6. What should make Claude pause instead of improvising?

## Anti-Vague Rewrites

Reject goals shaped like these:

- "Improve the app."
- "Fix all bugs."
- "Make it production ready."
- "Refactor this codebase."
- "Research this and do the best thing."

Convert them into a single outcome plus proof the evaluator can actually see:

- Instead of "Improve the app": "Dashboard initial load time is reduced by at least 25% versus the baseline benchmark shown earlier in this conversation, with no visible behavior regressions, proven by re-running the benchmark script and pasting its output."
- Instead of "Fix all bugs": "The checkout flow's Playwright suite passes — shown by running `npx playwright test checkout` and pasting a clean output — with no previously-passing test broken."
- Instead of "Refactor this codebase": "Duplicated auth/session logic is extracted into one shared module, `npm test` output pasted showing all tests green, and no public API signature changed."

## Output Contract

When the hard gate is satisfied, output two separate pieces:

```text
Kickoff prompt (send this first, as a normal message):
[task instructions, context to read, constraints, operating rules,
what to re-check each iteration, when to pause instead of guessing]

Goal condition (then run exactly this):
/goal [single evaluator-checkable condition, <4000 chars]
```

Also include a short "Why this is safe to run" note: the success condition, the main risk, and what proof will actually appear in the transcript.

Keep the goal condition itself tight — it is the string passed to `/goal`, not the whole brief. Put scope/context/operating-rule detail in the kickoff prompt, not in the condition.

## Do Not Silently Start

If the user asked only to draft a goal, do not run `/goal` yourself. Present the kickoff prompt and the goal condition, and start them only if the user explicitly confirms — since once `/goal` is active, Claude will keep iterating on its own after every turn until the evaluator agrees it's met.

If the user explicitly asked to start the goal too, show the final draft first when there was any interview or inference. Only send the kickoff prompt and run `/goal` after the user confirms the draft matches their intent.

## If `/goal` Doesn't Seem to Be Working

- Check `/goal` with no arguments to see current status.
- If it never triggers a stop/continue decision, the environment may have hooks disabled (`disableAllHooks` or `allowManagedHooksOnly` in settings) — `/goal` depends on a session-scoped hook internally and silently can't function without it.
- If the goal was met or cleared before the session ended, it will not carry over on `--resume`/`--continue` — redraft and re-run `/goal` in the new session.
