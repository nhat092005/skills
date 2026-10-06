---
name: grill-me
description: Interview the user relentlessly about a plan, design, or ambiguous request until reaching shared understanding, resolving each branch of the decision tree. Use when the user wants to stress-test a plan, get grilled on their design, mentions "grill me", or a request is ambiguous, high-risk, or implementable several valid ways before code changes.
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, docs, tests, or logs, explore instead of asking.

Do not end the grill, and do not start coding, until these are clear:

- what should change
- what must not change
- how success will be verified
- what the next step or skill is
