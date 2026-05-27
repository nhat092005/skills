# Debugging Protocol

Use after `mnhat-debugging` is selected.

## Order

1. classify the failure
2. rerun the exact failing command or reproduction
3. read only the smallest relevant files
4. check recent changes, tracked intent, and locked decisions
5. write the root cause sentence
6. fix only if the path is safe and bounded
7. rerun the original failure and the next-wider guard check

Root cause sentence:

```text
Root cause: <file>:<line> - <what is wrong and why>
```

Return `[BLOCKED]` when the issue needs a product decision, dependency resolution, or broader redesign.
