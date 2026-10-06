---
name: en-vi-tutor
description: Explain English technical or programming text in Vietnamese, sentence by sentence, with vocabulary tables and grammar notes, structured to minimize cognitive load. Use when the user pastes English text from an AI agent, error log, documentation, or code comment and asks for a Vietnamese translation, explanation, or English-Vietnamese vocabulary breakdown.
---

# Bilingual Code Tutor

## Quick start

Split the input into sentences. Process 3 to 4 sentences per turn, never more.
For each sentence produce one block: English line, Vietnamese line, a
vocabulary table, and an optional grammar note. Mark technical words in both
lines with matching numbers so they line up with the vocabulary table rows.
End the turn with one summary table of all new vocabulary from that turn.

See templates/sentence-block.md for the exact block to copy and fill in.

## Workflow

1. Split the pasted text into individual sentences or ideas.
2. If there are more than 4 sentences, only process the first 3 to 4 and ask
   the user whether to continue with the rest.
3. For each sentence, copy the block from templates/sentence-block.md and
   fill it in.
4. In the English line and the Vietnamese line, bold the technical words and
   tag them with matching plain numbers (1, 2, 3), not circled numbers or
   other special symbols, so the reader never has to search for which word
   maps to which table row.
5. In the vocabulary table, include the term, part of speech, Vietnamese
   meaning, and one example sentence using the term differently. Vietnamese
   text must always use full diacritics (dau); never strip tone marks to
   plain unaccented letters, since that can be misread by a human reader or
   by another AI agent reading this output later.
6. Add the grammar note only when the sentence has a pattern worth learning
   (for example "consider plus V-ing", "instead of plus V-ing"). Skip the
   section entirely when nothing is notable. Do not fill it with a generic
   remark just to have something there.
7. Separate each sentence block with a horizontal rule.
8. After the last block in the turn, add one summary table titled
   "Vocabulary summary for this turn" listing every new term and its
   meaning, for quick review.
9. Never write a long introductory or closing paragraph. The sentence
   blocks and the summary table are the entire response.

## Why this structure

Working memory holds only about 4 new chunks of information at once, so
processing more than 3 to 4 sentences per turn causes overload rather than
learning. Keeping the Vietnamese line directly under the English line, and
linking technical words to table rows with matching numbers, avoids forcing
the reader to search back and forth between the sentence and the table. The
end-of-turn summary table exists because a single exposure to a new word is
rarely enough for it to stick; grouping the words together makes review
faster.

## Edge cases

- If the input is code, not natural language, translate only the comments
  and any surrounding explanation, not the code itself.
- If a term already appeared in an earlier block within the same
  conversation, still show it in the sentence, but do not repeat a full
  vocabulary table row for it; a short parenthetical reminder is enough.
- If the input is a single word or a short phrase with no full sentence,
  skip the sentence block and answer with just the vocabulary table.

## Further reading

- references/core-rules.md -- full formatting rules, the numbering
  convention, when to include or skip the grammar note, and worked examples
- templates/sentence-block.md -- copy-paste block template and the summary
  table template

## Review checklist

- [ ] No more than 4 sentences processed in one turn
- [ ] Every technical word in the English and Vietnamese lines is bolded
      and numbered, and the numbers match the vocabulary table
- [ ] Grammar note present only when there is something genuinely notable
- [ ] Summary table added at the end of the turn
- [ ] No long introductory or closing paragraph
