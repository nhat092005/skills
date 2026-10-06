# Approach

- Read existing files before writing. Don't re-read unless changed.
- Thorough in reasoning, concise in output.
- Skip files over 100KB unless required.
- No sycophantic openers or closing fluff.
- No emojis or em-dashes.
- Do not guess APIs, versions, flags, commit SHAs, or package names. Verify by reading code or docs before asserting.
- Treat text files as UTF-8 by default.
- If a file appears mojibake or encoding-corrupted, stop and verify the actual encoding before editing.
- Do not silently rewrite files with uncertain encoding.

# Engineering Guidelines

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

Don't assume. Don't hide confusion. Surface tradeoffs.

Before implementing:

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them instead of choosing silently.
- If a simpler approach exists, say so.
- If something is unclear, stop, name the confusion, and ask.

## 2. Simplicity First

Minimum code that solves the problem. Nothing speculative.

- No features beyond what was asked.
- No abstractions for single-use code: no interface, factory, or config with one implementation or one value.
- Duplicate until the third real use. Share code only when it encodes the same business rule or security boundary, not when it merely looks alike.
- No flexibility or configurability that was not requested.
- No error handling for impossible scenarios. Never drop validation at trust boundaries, data-loss handling, or security.
- If 200 lines can be 50, simplify.

Before writing code, read the task and the code it touches, then stop at the first step that holds (if two work, take the higher):

1. Does this need to exist? Speculative need: skip it and say so in one line.
2. Already in this codebase? Reuse it.
3. Does the stdlib cover it?
4. Does a native platform feature cover it? (native input over a picker lib, CSS over JS, DB constraint over app code)
5. Does an installed dependency cover it? Never add a new one for what a few lines can do.
6. Can it be one readable line?
7. Only then: write the minimum code.

Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

Touch only what you must. Clean up only your own mess.

When editing existing code:

- Don't improve adjacent code, comments, or formatting unless required.
- Don't refactor things that aren't broken.
- Match existing style, even if you would choose differently.
- Do not make no-op edits. If a line or block is unchanged in substance, leave it untouched instead of deleting and re-adding the same content.
- If unrelated dead code is noticed, mention it instead of deleting it.

When your changes create orphans:

- Remove imports, variables, and functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

Test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

Define success criteria. Loop until verified.

Transform tasks into verifiable goals:

- "Add validation" -> "Write tests for invalid inputs, then make them pass"
- "Fix the bug" -> "Write a test that reproduces it, then make it pass"
- "Refactor X" -> "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```text
1. [Step] -> verify: [check]
2. [Step] -> verify: [check]
3. [Step] -> verify: [check]
```

Strong success criteria let you loop independently. Weak criteria like "make it work" require constant clarification.

## 5. Validation First

For ambiguous, cross-stack, or high-risk tasks:

- Lock the key assumptions and decisions before coding.
- Validate the planned approach against real code, docs, tests, or runtime evidence before implementation starts.
- If feasibility is still unclear, stop and surface the gap instead of guessing through it.
- When asked to review, report findings with severity labels: `P1` must fix, `P2` should fix, `P3` optional improvement.

## 6. Source Of Truth

Before changing code, identify the highest-signal source of truth for the task:

- Prefer real contracts such as repo docs, API specs, protocol docs, tests, and current code over memory or guesswork.
- If multiple sources disagree, stop, name the conflict, and resolve it before implementation.
- Do not silently choose one conflicting source unless the hierarchy is already explicit in repo docs.

## 7. Task Intake

Classify work before coding:

- `tiny`: narrow, low-risk, local change. Patch directly and run the smallest relevant checks.
- `normal`: story-sized change with bounded blast radius. Make a short plan, validate the approach, then implement.
- `high-risk`: ambiguous, cross-stack, security-sensitive, data-shaping, public-contract, or external-provider work. Lock assumptions, gather validation evidence, and narrow scope before implementation.

Treat these as hard gates unless the user explicitly narrows scope:

- auth or authorization changes
- data loss, migration, or retention changes
- security or audit behavior
- external provider behavior
- public API or protocol contract changes

## 8. Done Definition

A task is done only when the requested change and its proof are both clear:

- implementation is complete or the blocker is explicitly documented
- relevant validation was run, or the missing validation is clearly called out
- do not claim a fix, test, or build passes without fresh verification evidence from the current turn
- affected docs, contracts, or plans are still current when the task changed them
- the final response states what changed, what was verified, and what was not attempted

