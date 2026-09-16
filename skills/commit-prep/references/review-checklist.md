# Review Checklist

Use this before claiming a commit plan, message, or execution path is ready.

## Convention detection

- [ ] The convention came from repo truth or an explicit user request
- [ ] Mixed or weak signals were called out instead of silently merged
- [ ] Conventional Commits was only used as fallback when no stronger signal existed

## Commit shaping

- [ ] Each proposed commit has one coherent intent
- [ ] Mixed concerns were split when they could stand alone
- [ ] Code, tests, and docs were only kept together when the story truly required it

## Message quality

- [ ] The header matches the chosen convention
- [ ] Body requirements were satisfied for the chosen format
- [ ] Footers or trailers match the selected workflow
- [ ] Breaking or patch-related metadata is expressed in the correct style

## Execution boundary

- [ ] `git add` or `git commit` is only proposed as an action when the user explicitly asked
- [ ] Real commit execution preserves the intended split and leaves unrelated work out
- [ ] `Signed-off-by:` and `Fixes:` handling matches the selected convention
