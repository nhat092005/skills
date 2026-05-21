---
name: exploring
description: Capture locked user-facing decisions for a fuzzy request before planning or execution. Use when a feature idea is still ambiguous and needs scope, boundary, and context written down before implementation research, goal-setting, or coding.
---

# Exploring

Use when intent is real but still underspecified.

Exploring turns fuzzy requests into locked decisions in `.mnhat/exploring/<feature-slug>/CONTEXT.md`. Clarify scope without deep implementation research, architecture proposals, task creation, or code changes.

## Hard Gates

- Ask one question at a time; wait for the user before asking the next.
- Do not answer your own question.
- Do not do deep implementation research, create tasks, propose architecture, or write code.
- End when the context file is specific enough for the next planning or goal-setting step.

## Flow

1. **Scope**
   - Classify: `Quick`, `Standard`, or `Deep`.
   - If this continues existing work, read the relevant `bd` item and any relevant `bd remember` context first.
   - If the request spans independent subsystems, pick one and defer the rest.

2. **Domain**
   - Classify each applicable type:
     - `SEE`: user-visible surface
     - `CALL`: API, CLI, webhook, SDK, or service interface
     - `RUN`: job, script, service, or pipeline
     - `READ`: docs, emails, reports, or notifications
     - `ORGANIZE`: data model, file layout, taxonomy, or config
   - Load `references/gray-area-probes.md` and choose only relevant probes.

3. **Gray Areas**
   - Generate 2-4 unstated product decisions that would make downstream work guess.
   - Do a quick scout only:
     ```bash
     rg "<feature-keyword>" src app packages --glob "*.{ts,tsx,js,jsx,py,md}" | head -20
     ```
   - Read 2-3 relevant files and cite existing patterns in questions.
   - Exclude implementation choices, performance tuning, and new scope.

4. **Socratic Locking**
   - Ask one concise question per message, preferably single-choice.
   - Start broad, then narrow into constraints.
   - After each decision, confirm it and assign a stable ID: `D1`, `D2`, `D3`.
   - For scope creep, mark it as deferred and return to the current question.

5. **Context Assembly**
   - Write `.mnhat/exploring/<feature-slug>/CONTEXT.md` from `references/context-template.md`.
   - Include boundary, domain types, locked decisions, scout paths, references, open questions, and deferred ideas.
   - Use concrete language. No placeholders, TODOs, or vague preferences.
   - Review once for contradictions, vague decisions, missing IDs, and blockers. Use a second reviewer only if the user explicitly asks for another pass.

6. **State And Handoff**
   - Tell the user:
     ```text
     Decisions captured. CONTEXT.md written to `.mnhat/exploring/<feature>/CONTEXT.md`.
     CONTEXT.md is the source of truth for downstream planning or goal-setting.
     Next step: use $goal-griller or your preferred planning workflow.
     ```

Anti-patterns: bundled questions, deep implementation analysis, architecture proposals, speculative `bd` task trees, code changes, or skipping decision locking.

References: `references/gray-area-probes.md`, `references/context-template.md`.
