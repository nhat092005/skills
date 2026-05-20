# Global Codex Skills

This directory is the user-level skill root described by the OpenAI Codex docs.

Use this layout:

- `~/.codex/AGENTS.md`: always-on operating rules
- `~/.codex/config.toml`: Codex runtime configuration
- `~/.codex/hooks.json`: enforcement and lifecycle hooks
- `~/.agents/skills/<skill-name>/SKILL.md`: global reusable workflows
- `<repo>/.agents/skills/<skill-name>/SKILL.md`: repo-specific workflows

Design rules for long-term maintenance:

- Keep each skill focused on one failure mode or workflow.
- Put trigger conditions in `description`. Do not summarize the workflow there.
- Keep repo-specific conventions out of global skills.
- Use repo docs such as `CONTEXT.md`, ADRs, API docs, and tests as source of truth when they exist.
- Keep glossary/domain docs separate from implementation notes.
- Prefer explicit invocation for heavy process skills. Only allow implicit invocation when a skill is intentionally broad and low-risk.

Current default routing policy:

- `repo-bootstrap` and `diagnose-loop` may auto-trigger because they are broad, low-risk guardrails.
- `plan-grill`, `tdd-slice`, `zoom-out-architecture`, and `context-glossary` stay explicit because they steer workflow more aggressively.

Superpowers integration snapshot:

- Kept as local skills by adaptation, not direct import: `diagnose-loop`, `tdd-slice`, `plan-grill`.
- Pulled into always-on rules instead of standalone skills: verification-before-claims discipline.
- Deliberately not imported: framework bootstrap, mandatory subagent orchestration, heavy plan executors, and worktree-first defaults.

Docs note:

- Current OpenAI docs are not fully consistent about `~/.agents/skills` versus `~/.codex/skills`.
- This setup treats `$HOME/.agents/skills` as the user-authored global skill root.
- Treat `~/.codex/skills` as Codex-owned system/internal territory unless future official docs become unambiguous in the other direction.

This starter set borrows the useful ideas from `mattpocock/skills`:

- small composable skills
- skills organized around recurring agent failure modes
- glossary/domain language separated from implementation detail
- setup/bootstrap treated as its own workflow

Patterns worth keeping for Codex:

- `CONTEXT.md` is a glossary only. Do not turn it into a spec or scratchpad.
- TDD should run in vertical slices: one failing behavior, one minimal fix, repeat.
- Architecture needs explicit attention. Add a zoom-out step when local changes may deepen coupling or spread complexity.
- Verification claims require fresh evidence from the current turn.
