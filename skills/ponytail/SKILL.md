---
name: ponytail
description: Adjust how strictly the "Simplicity First" ladder in AGENTS.md is applied. Use when the user types /ponytail with lite, full, ultra, or off, or says "be lazy", "yagni", "do less", "simplest solution".
argument-hint: "[lite|full|ultra|off]"
---

# Ponytail

Overrides the strictness of the "Simplicity First" ladder for the rest of the session. Default is full.

- lite: build what was asked, name the lazier alternative in one line. User picks.
- full: ladder enforced, stdlib and native first, shortest diff.
- ultra: deletion before addition. Ship the one-liner, challenge the rest of the requirement.
- off: ignore the ladder until the level changes.

"Never simplify away" in AGENTS.md applies at every level.

Idea from github.com/dietrichgebert/ponytail (MIT).
