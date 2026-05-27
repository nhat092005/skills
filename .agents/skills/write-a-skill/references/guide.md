# Skill Writing Guide

Deep reference for the write-a-skill skill.
Read this when you need detail beyond what SKILL.md covers.

## Table of contents

1. Directory structure rules
2. Frontmatter fields
3. Description writing
4. Progressive disclosure
5. SKILL.md body rules
6. When to add references/
7. When to add scripts/
8. When to add assets/
9. Full checklist

---

## 1. Directory structure rules

The only required file is SKILL.md at the root of the skill directory.

```
.agents/
└── skills/
    └── skill-name/
        ├── SKILL.md           # required
        ├── agents/
        │   └── openai.yaml    # recommended when the skill exposes an agent surface
        ├── references/        # optional; deep docs, one file per domain
        │   └── topic.md
        └── scripts/           # optional; reusable executable helpers
            └── helper.py
```

Do not create a directory unless it will actually be populated.
Do not nest directories more than one level deep inside references/.
Do not put REFERENCE.md or EXAMPLES.md at the root -- use references/ instead.
If `agents/openai.yaml` exists, it should declare `interface` and `policy` explicitly.

---

## 2. Frontmatter fields

Required:

    name           Skill identifier. lowercase-kebab-case.
                   Must match the directory name exactly.

    description    Primary trigger mechanism. See section 3.

Optional:

    compatibility  Required tools or dependencies. Rarely needed.
                   Omit unless the skill genuinely cannot run without
                   something that is not obvious from context.

Do not add any other fields. No version, no author, no date.

---

## 3. Description writing

The description is the only thing the agent reads when deciding whether to
load a skill. It must contain enough signal to win against other skills
in the available_skills list.

Rules:
- Max 1024 characters
- First sentence: what the skill does
- Second sentence onwards: when to trigger it, starting with "Use when"
- Name specific keywords, file types, action verbs, domain terms
- Be slightly pushy -- agents undertrigger skills by default
- Do not put workflow details, file pointers, or examples here

Good:
    Extract text and tables from PDF files, fill forms, merge documents.
    Use when working with PDF files or when user mentions PDFs, forms,
    or document extraction.

Bad:
    Helps with documents.

The bad example gives the agent nothing to distinguish it from other skills.

---

## 4. Progressive disclosure

Skills load in three levels:

Level 1 -- name + description (always in context, ~100 words)
    Used only for skill selection. Never put workflow detail here.

Level 2 -- SKILL.md body (in context when skill triggers, target under 100 lines)
    Contains quick start, main workflows, lookup tables, pointers to level 3.
    Move anything over ~100 lines into references/.

Level 3 -- references/, scripts/, assets/ (loaded on demand, unlimited size)
    The agent reads a reference file only when SKILL.md tells it to.
    Scripts execute without being loaded into context at all.

Key rule: if content is needed on every invocation, put it in SKILL.md.
If it is needed only sometimes, put it in references/.

---

## 5. SKILL.md body rules

Voice: use imperative form. "Read the file" not "You should read the file".

Explain the why. Agents make better decisions when they understand the
reason behind an instruction. Avoid bare MUST/NEVER without explanation.

Keep it lean. Remove anything not actively used. If a section has never
helped in practice, cut it.

No time-sensitive content. No version numbers, no URLs that can rot,
no current dates. Skills are reused many times.

Consistent terminology. Pick one term per concept and use it everywhere.

Concrete examples. One worked example is worth three paragraphs of prose.

Default to ASCII. Allow `├──`, `└──`, and `│` when drawing directory trees
or other structural diagrams where they materially improve readability.

Lookup tables for frequently needed data: put them inline in SKILL.md.
Deep explanations and edge cases: put them in references/.

---

## 6. When to add references/

Add a file in references/ when:
- SKILL.md would exceed ~100 lines without it
- Content is for a specific domain variant (aws.md, gcp.md, azure.md)
- Content is for advanced cases not needed on every invocation

Each reference file must:
- Start with a title and one-line description of what it covers
- Have a table of contents if longer than 300 lines
- Default to ASCII; allow `├──`, `└──`, and `│` for tree diagrams

Every reference file must be pointed to from SKILL.md. Do not put
files in references/ that SKILL.md never mentions.

Pointer format in SKILL.md:

    ## Further reading

    - references/topic.md  -- what it covers and when to read it

---

## 7. When to add scripts/

Add a script when:
- The same code would be generated repeatedly across invocations
- The operation is deterministic and needs explicit error handling
- Running the script is faster and more reliable than inline generation

Good candidates: validators, formatters, code generators, aggregators.
Bad candidates: one-off helpers, trivially short code with no error handling.

Tell the agent in SKILL.md when and how to invoke each script.
Scripts execute without being loaded into context, saving tokens.

---

## 8. When to add assets/

Add an asset when:
- The skill produces output from a fixed template (docx, html, csv)
- The file is binary or structured and cannot be reliably generated fresh

Tell the agent in SKILL.md which asset to use and for what purpose.

---

## 9. Full checklist

Structure:
[ ] SKILL.md at skill root
[ ] No empty directories
[ ] No REFERENCE.md or EXAMPLES.md at root level; use references/ instead
[ ] references/ files are one level deep only

Frontmatter:
[ ] name matches directory name, lowercase-kebab-case
[ ] description under 1024 characters
[ ] description sentence 1: what the skill does
[ ] description sentence 2+: when to trigger with specific keywords
[ ] No extra frontmatter fields

SKILL.md body:
[ ] Under 100 lines (500 is the hard ceiling)
[ ] No time-sensitive information
[ ] Consistent terminology throughout
[ ] At least one concrete example per major workflow
[ ] Pointers to all references/ files with when-to-read guidance
[ ] Default to ASCII; allow `├──`, `└──`, and `│` for tree diagrams

Reference files:
[ ] Every file in references/ is pointed to from SKILL.md
[ ] Files over 300 lines have a table of contents
[ ] Default to ASCII; allow `├──`, `└──`, and `│` for tree diagrams

Description:
[ ] First sentence states what the skill does
[ ] Subsequent sentences state when to trigger with specific keywords
[ ] Slightly pushy; advocates for itself across different phrasings
[ ] No workflow details or file pointers
