# Makefile Reference Quick Map

Covers where to look first for common GNU Make and Kbuild questions across this skill's reference set.

Source: Internal map for the `makefile` skill references

---

Use this file first when you know the topic you need, but not which
reference file covers it.

## GNU Make topics

| Need | Read first | Why |
|------|------------|-----|
| Variable naming rules | `gnu-variables.md` | Covers uppercase vs lowercase naming and `*FLAGS` conventions. |
| `:=`, `=`, `?=`, `+=`, `!=` | `gnu-variables.md` | Explains variable flavors, when they evaluate, and when to use them. |
| `override`, env vs CLI priority | `gnu-variables.md` | Covers override order and command-line precedence. |
| Target-specific variables or `private` | `gnu-variables.md` | Covers per-target variable scope and propagation limits. |
| `export` to sub-make | `gnu-variables.md` | Shows explicit `export` patterns and what gets exported automatically. |
| Mandatory flags plus user-overridable flags | `gnu-variables.md` | Covers the `ALL_CFLAGS` layering pattern. |
| Standard targets like `install`, `clean`, `distclean`, `check` | `gnu-targets.md` | Defines standard GNU target behavior and expectations. |
| `.PHONY` usage | `gnu-targets.md` | Explains when a target must be declared phony. |
| Install directories like `prefix`, `bindir`, `libdir` | `gnu-targets.md` | Covers installation directory variables and their meanings. |
| `DESTDIR` staged installs | `gnu-targets.md` | Covers staged install behavior and correct install command shapes. |
| `$@`, `$<`, `$^`, `$+`, `$|` | `automatic-vars.md` | Covers automatic variables and recipe-only scope. |
| Pattern rules | `automatic-vars.md` | Shows automatic variables in pattern-rule context. |
| Full GNU-style project example | `gnu-c-project.mk` | Copyable skeleton with variables, pattern rules, install, and clean targets. |
| Recursive monorepo root example | `monorepo-root.mk` | Copyable root Makefile that exports variables and delegates with `$(MAKE) -C`. |

## Kbuild topics

| Need | Read first | Why |
|------|------------|-----|
| `obj-y`, `obj-m`, `obj-$(CONFIG_FOO)` | `kbuild.md` | Covers core Kbuild goal definitions and config-driven inclusion. |
| `ccflags-y`, `subdir-ccflags-y`, `CFLAGS_file.o` | `kbuild.md` | Covers Kbuild flag scopes and per-file overrides. |
| `$(src)` and `$(obj)` | `kbuild.md` | Covers special rules and generated-file path handling. |
| `KERNELRELEASE` wrapper logic | `kbuild-module.mk` | Shows the split between the userspace entry path and the Kbuild branch. |
| External kernel module skeleton | `kbuild-module.mk` | Provides a copyable out-of-tree module example. |
| `if_changed` and `targets +=` | `kbuild.md` | Covers custom command rebuild behavior and common mistakes. |
| Top-level exported Kbuild variables | `kbuild.md` | Covers variables like `KERNELRELEASE`, `ARCH`, and install paths. |
| Host build tools such as `hostprogs-y` | `kbuild.md` | Covers host-side programs, flags, and when they are built. |

## Suggested lookup order

1. Start here if the question is "which file covers X?"
2. Open the theory file first for rules and constraints.
3. Open the `.mk` example next if you need a copyable skeleton.
4. Return to `makefile/SKILL.md` if the bigger question is really about choosing GNU vs Kbuild vs monorepo structure.
