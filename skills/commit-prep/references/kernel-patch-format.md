# Linux Kernel Patch Format

Use this only when the repo truth or user request clearly points to Linux-kernel-style patch commits.
Read this when the chosen format is `subsystem: summary` plus patch trailers.

## Core structure

`subsystem: short summary in imperative mood`

Blank line.

Required explanatory body wrapped around 75 columns.

Trailer lines such as `Signed-off-by:` and `Fixes:`.

## Body requirements

Explain all three:

1. what the problem is
2. what impact it has
3. what the fix or change does

If the change is an optimization, include concrete measurements when available.

## Trailer rules

- `Signed-off-by:` is required on every commit.
- `Fixes:` should use the 12-character SHA plus the original summary in quotes.
- Other common trailers include `Reviewed-by:`, `Tested-by:`, `Acked-by:`, `Reported-by:`, and `Link:`.
- `Co-developed-by:` should be paired with that developer's `Signed-off-by:`.

## Boundaries

- Do not map kernel-style patch commits onto `feat:` or `fix:` prefixes.
- Do not omit the body.
- Do not recommend this format just because the change is low-level C; use it when the repo workflow actually points here.

## Related template

- `templates/kernel-patch.txt`
