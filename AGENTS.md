@../.codex/RTK.md
@../.codex/CONTEXT-MODE.md
@../.codex/BD_WORKFLOW.md

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

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them instead of choosing silently.
- If a simpler approach exists, say so.
- If something is unclear, stop, name the confusion, and ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No flexibility or configurability that was not requested.
- No error handling for impossible scenarios.
- If 200 lines can be 50, simplify.

Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

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

**Define success criteria. Loop until verified.**

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

## 9. Implementation Notes

When implementing any feature or spec, always maintain a running `implementation-notes.md` file in the current project root documenting:
- Decisions you made that weren't in the spec
- Things you had to change and why
- Tradeoffs you made
- Anything else the user should know

# ESP-IDF Environment

Before running any ESP-IDF commands (idf.py, esptool, etc.), always run: `. $HOME/.espressif/v5.4.2/esp-idf/export.sh`

<!-- context7 -->
Use Context7 MCP to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service -- even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer -- your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Steps

1. Always start with `resolve-library-id` using the library name and the user's question, unless the user provides an exact library ID in `/org/project` format
2. Pick the best match (ID format: `/org/project`) by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question). Use version-specific IDs when the user mentions a version
3. `query-docs` with the selected library ID and the user's full question (not single words)
4. Answer using the fetched docs
<!-- context7 -->

<!-- gitnexus:start -->
# GitNexus — Code Intelligence

This project is indexed by GitNexus as **skills** (24 symbols, 22 relationships, 0 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

> If any GitNexus tool warns the index is stale, run `npx gitnexus analyze` in terminal first.

## Always Do

- **MUST run impact analysis before editing any symbol.** Before modifying a function, class, or method, run `gitnexus_impact({target: "symbolName", direction: "upstream"})` and report the blast radius (direct callers, affected processes, risk level) to the user.
- **MUST run `gitnexus_detect_changes()` before committing** to verify your changes only affect expected symbols and execution flows.
- **MUST warn the user** if impact analysis returns HIGH or CRITICAL risk before proceeding with edits.
- When exploring unfamiliar code, use `gitnexus_query({query: "concept"})` to find execution flows instead of grepping. It returns process-grouped results ranked by relevance.
- When you need full context on a specific symbol — callers, callees, which execution flows it participates in — use `gitnexus_context({name: "symbolName"})`.

## Never Do

- NEVER edit a function, class, or method without first running `gitnexus_impact` on it.
- NEVER ignore HIGH or CRITICAL risk warnings from impact analysis.
- NEVER rename symbols with find-and-replace — use `gitnexus_rename` which understands the call graph.
- NEVER commit changes without running `gitnexus_detect_changes()` to check affected scope.

## Resources

| Resource | Use for |
|----------|---------|
| `gitnexus://repo/skills/context` | Codebase overview, check index freshness |
| `gitnexus://repo/skills/clusters` | All functional areas |
| `gitnexus://repo/skills/processes` | All execution flows |
| `gitnexus://repo/skills/process/{name}` | Step-by-step execution trace |

## CLI

| Task | Read this skill file |
|------|---------------------|
| Understand architecture / "How does X work?" | `.claude/skills/gitnexus/gitnexus-exploring/SKILL.md` |
| Blast radius / "What breaks if I change X?" | `.claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md` |
| Trace bugs / "Why is X failing?" | `.claude/skills/gitnexus/gitnexus-debugging/SKILL.md` |
| Rename / extract / split / refactor | `.claude/skills/gitnexus/gitnexus-refactoring/SKILL.md` |
| Tools, resources, schema reference | `.claude/skills/gitnexus/gitnexus-guide/SKILL.md` |
| Index, status, clean, wiki CLI commands | `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` |

<!-- gitnexus:end -->

<!-- BEGIN BEADS CODEX SETUP: generated by bd setup codex -->
## Beads Issue Tracker

Use Beads (`bd`) for durable task tracking in repositories that include it. Use the `beads` skill at `.agents/skills/beads/SKILL.md` (project install) or `~/.agents/skills/beads/SKILL.md` (global install) for Beads workflow guidance, then use the `bd` CLI for issue operations.

### Quick Reference

```bash
bd ready                # Find available work
bd show <id>            # View issue details
bd update <id> --claim  # Claim work
bd close <id>           # Complete work
bd prime                # Refresh Beads context
```

### Rules

- Use `bd` for all task tracking; do not create markdown TODO lists.
- Run `bd prime` when Beads context is missing or stale.
- Keep persistent project memory in Beads via `bd remember`; do not create ad hoc memory files.
<!-- END BEADS CODEX SETUP -->
