---
name: write-a-skill
description: Create new agent skills with proper structure, progressive disclosure, and bundled resources. Use when user wants to create, write, or build a new skill.
---

# Writing Skills

## Process

1. **Gather requirements** - ask user about:
   - What task/domain does the skill cover?
   - What specific use cases should it handle?
   - Does it need executable scripts or just instructions?
   - Any reference materials to include?

2. **Draft the skill** - create:
   - SKILL.md with concise instructions
   - Files in references/ if content exceeds 100 lines
   - Utility scripts if deterministic operations needed

3. **Review with user** - present draft and ask:
   - Does this cover your use cases?
   - Anything missing or unclear?
   - Should any section be more/less detailed?

## Skill Structure

```
.agents/
└── skills/
    └── skill-name/
        ├── SKILL.md           # Main instructions (required)
        ├── agents/
        │   └── openai.yaml    # Agent interface and invocation policy (recommended)
        ├── references/        # Detailed docs, one file per domain (if needed)
        │   └── topic.md
        ├── scripts/           # Utility scripts (if needed)
        │   └── helper.py
        └── templates/         # Starter files or reusable scaffolds (if needed)
            └── starter.md
```

## SKILL.md Template

```
---
name: skill-name
description: Brief description of capability. Use when [specific triggers].
---

# Skill Name

## Quick start

[Minimal working example]

## Workflows

[Step-by-step processes with checklists for complex tasks]

## Further reading

- references/topic.md  -- what it covers and when to read it
```

## Description Requirements

The description is the only thing the agent sees when deciding which skill
to load. It is surfaced alongside all other installed skills and the agent
picks the relevant one based on this field alone.

Goal: give the agent just enough info to know:
1. What capability this skill provides
2. When to trigger it (specific keywords, contexts, file types)

Format:
- Max 1024 characters
- First sentence: what it does
- Second sentence: "Use when [specific triggers]"

Good example:
    Extract text and tables from PDF files, fill forms, merge documents.
    Use when working with PDF files or when user mentions PDFs, forms,
    or document extraction.

Bad example:
    Helps with documents.

The bad example gives the agent no way to distinguish this from other skills.
Agents undertrigger by default -- name specific contexts and keywords.

## When to Add Scripts

Add utility scripts when:
- Operation is deterministic (validation, formatting)
- Same code would be generated repeatedly
- Errors need explicit handling

Scripts save tokens and improve reliability vs generated code inline.

## When to Split Files

Split into references/ when:
- SKILL.md exceeds 100 lines
- Content has distinct domains (finance vs sales schemas)
- Advanced features are rarely needed

## Further reading

- references/guide.md  -- full rules for every section, progressive disclosure
                          levels, complete pre-ship checklist, good and bad
                          description examples
- agents/openai.yaml   -- add interface metadata and invocation policy when the skill should expose an explicit agent surface

## Review Checklist

After drafting, verify:
- [ ] Description includes triggers ("Use when...")
- [ ] SKILL.md under 100 lines
- [ ] No time-sensitive info
- [ ] Consistent terminology
- [ ] Concrete examples included
- [ ] References one level deep
- [ ] No empty directories
- [ ] Default to ASCII; allow `├──`, `└──`, and `│` for tree diagrams when they improve readability
