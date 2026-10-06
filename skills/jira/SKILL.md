---
name: jira-description
description: Write short Jira ticket descriptions and comments (feature, bug, progress report, blocker) in Jira wiki markup. Use when the user asks to write, format, update, or review a Jira description, Jira comment, Jira ticket, bug report, or mentions "jira-description", "viết jira", "tạo jira", "jira ticket", "comment jira".
---

# Jira

## Style

- Short, simple words, easy to read. Go straight to the point.
- One idea per bullet. No long paragraphs, no filler.
- Fill with concrete facts (names, values, commit). No vague text like "tested and fixed".

## Format (Jira wiki markup)

- No headings. Labels are bold: `*Requirement:*`.
- Bullets: `*`. Numbered steps: `#`.
- Multi-line code, logs, commands: wrap in `{code}` ... `{code}`.
- Inline code, file names, branch, commit, function, command: wrap in `{{...}}`.
- Output only the ticket text, ready to paste. Do not wrap it in a markdown code fence.

## Templates

- Ticket description (feature/task or bug): `templates/description.md`
- Comment (progress with pushed code, or blocker/question): `templates/comment.md`

Pick the matching section, fill it, drop empty optional fields (`Test`, `Demo`).
A comment that fits no template (plain question, short note): write it freely, keep it short.
