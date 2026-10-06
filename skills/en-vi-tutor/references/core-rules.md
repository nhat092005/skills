# Core Rules and Worked Examples

## Numbering convention

Use plain numbers (1, 2, 3 ...) in parentheses or brackets, not circled
numbers or other special symbols. The same number must appear in three
places for a given term: the English line, the Vietnamese line, and the
matching row of the vocabulary table. This is what lets the reader jump
straight from the sentence to the table row without searching.

Vietnamese text must always use full diacritics (dấu). Do not strip tone
marks to plain unaccented letters; text without diacritics is ambiguous and
can be misread by both people and other AI agents reading the output later.

## Sentence block, filled example

### 1. Runtime verification

🇬🇧 EN: Runtime verification (1) means actually running the app, instead of
(2) just reading code (static analysis) (3).

🇻🇳 VI: Kiểm chứng lúc chạy (1) nghĩa là thực sự bật app lên, thay vì (2)
chỉ đọc code (phân tích tĩnh) (3).

📝 Vocabulary:
| # | Term | Part of speech | Meaning | Another example |
|---|---|---|---|---|
| 1 | runtime verification | noun phrase | kiểm chứng lúc chạy | "We need runtime verification before release." |
| 2 | instead of + V-ing | prepositional phrase | thay vì (làm gì) | "Instead of guessing, check the logs." |
| 3 | static analysis | noun phrase | phân tích tĩnh | "Static analysis caught the bug early." |

💡 Grammar note: after "instead of", the verb always takes the -ing form
(reading, not read).

---

### 2. Sandbox

🇬🇧 EN: Sandbox (1) refers to an isolated (2) server environment with
limited tools.

🇻🇳 VI: Sandbox (1) là môi trường server bị cô lập (2), thiếu công cụ.

📝 Vocabulary:
| # | Term | Part of speech | Meaning | Another example |
|---|---|---|---|---|
| 1 | sandbox | noun | môi trường hộp cát, cô lập | "Test it in the sandbox first." |
| 2 | isolated | adjective | bị cô lập, tách biệt | "The bug happened in an isolated case." |

(No grammar note here, nothing unusual in the sentence structure.)

---

### 📚 Vocabulary summary for this turn
| Term | Meaning |
|---|---|
| runtime verification | kiểm chứng lúc chạy |
| instead of + V-ing | thay vì (làm gì) |
| static analysis | phân tích tĩnh |
| sandbox | môi trường hộp cát, cô lập |
| isolated | bị cô lập |

## When to include the grammar note

Include it only when the sentence has a pattern that is:
- reusable in other technical sentences (a fixed pattern like "consider +
  V-ing", "instead of + V-ing", "there is a risk of + noun/V-ing")
- not obvious from the vocabulary table alone

Skip it when the sentence is grammatically simple, or when the only
noteworthy thing is already covered by the vocabulary table.

## Handling long input

If the user pastes a paragraph with more than 4 sentences:
1. Count the sentences first.
2. Process the first 3 to 4 only.
3. End the turn with: "There are still N more sentences, do you want me to
   continue?"
4. Wait for the user to confirm before continuing.

Do not silently cut off content without saying how much is left.

## Formatting rules

- Always use a table for vocabulary, never a bulleted list.
- Always place the Vietnamese line directly under the English line, not
  separated by other content.
- Do not add a summary paragraph before the first block or after the last
  table. The blocks and the final summary table are the complete answer.
- Keep the "Another example" column short, one sentence, showing the term
  used in a different context than the original sentence.
