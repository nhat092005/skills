---
name: makefile
description: Write, review, and fix GNU Make and Kbuild Makefiles for C/C++ projects, Linux kernel modules, and recursive monorepo builds. Use when the user mentions Makefile, GNU Make, Kbuild, obj-m, KERNELRELEASE, CFLAGS, phony targets, install or clean rules, or wants to create or repair a C/C++ build.
---

# Makefile Skill

## Quick start

1. Classify the build before editing:
- GNU-style app or library
- Kbuild kernel module or kernel subtree
- Recursive monorepo root

2. Read the existing Makefile first and match its local style unless it is broken.
3. Start from the closest example file, then adapt only the config, sources, and targets.
4. Keep user-overridable flags in `CFLAGS`, `CPPFLAGS`, and `LDFLAGS`; put mandatory flags in internal variables.
5. If you know the concept but not the reference file, open `references/quick-map.md` first.

Example trigger mapping:
- `obj-m`, `ccflags-y`, `KERNELRELEASE` -> Kbuild
- `prefix`, `DESTDIR`, `install`, `distclean` -> GNU-style
- `$(MAKE) -C`, multiple services or libs -> recursive monorepo root

## Workflows

### New GNU-style Makefile

1. Copy the structure from `references/gnu-c-project.mk`.
2. Keep the shell/default-goal header and declare all non-file targets in `.PHONY`.
3. Expose tool variables and user flags through standard GNU variable names.
4. Use pattern rules plus automatic dependency generation instead of repeating compile commands.
5. Add `install`, `uninstall`, `clean`, and `distclean` only if the project actually needs them.

### New Kbuild Makefile

1. Use `references/kbuild-module.mk` for an out-of-tree module.
2. Split the userspace entry path from the `KERNELRELEASE` branch.
3. Use `obj-m`, `obj-y`, `<module>-y`, `ccflags-y`, and per-file flags exactly as Kbuild expects.
4. Do not invent GNU-style install or clean rules inside the Kbuild section.

### Review or repair an existing Makefile

1. Identify the build style from variables and targets before proposing edits.
2. Check variable layering, `.PHONY`, recursive `$(MAKE)` usage, and target naming.
3. Prefer surgical fixes over a rewrite unless the file is structurally wrong.
4. If the file mixes GNU Make and Kbuild patterns incorrectly, separate them instead of papering over the mismatch.

## Further reading

- `references/quick-map.md` -- first-stop index for "which file covers export, variable naming, pattern rules, Kbuild flags, or examples?"
- `references/gnu-c-project.mk` -- copyable GNU-style C/C++ project skeleton
- `references/monorepo-root.mk` -- copyable recursive root Makefile for multi-service trees
- `references/kbuild-module.mk` -- copyable out-of-tree kernel module Makefile
- `references/gnu-variables.md` -- variable flavors, naming, export rules, and flag layering
- `references/gnu-targets.md` -- standard GNU targets, install directories, and `DESTDIR`
- `references/automatic-vars.md` -- `$@`, `$<`, `$^`, `$+`, `$|`, and common rule mistakes
- `references/kbuild.md` -- `obj-*`, `ccflags-y`, subdirectory descent, and Kbuild-specific rules
