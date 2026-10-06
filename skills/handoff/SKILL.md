---
name: handoff
description: Compact the current conversation into a handoff document so a fresh agent can continue the work. Use when the user asks for a handoff, to hand over, or to continue in a new session.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

# Handoff

Write a document summarising the conversation so a fresh agent can continue.

- Save it to the OS temp directory (`$TMPDIR`, else `/tmp`), not the workspace.
- Include a "suggested skills" section naming the skills the next agent should load.
- Do not copy what other artifacts already hold (specs, plans, ADRs, commits, diffs). Reference them by path or URL.
- Redact secrets and personal data.
- If the user passed arguments, tailor the document to that next task.

Idea from github.com/mattpocock/skills.
