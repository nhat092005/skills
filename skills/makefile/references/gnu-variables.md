# GNU Make Variables -- Deep Reference

Covers variable flavors, naming rules, override behavior, export rules, and flag layering patterns for GNU-style Makefiles.

Source: GNU Make Manual
        GNU Coding Standards, Makefile Conventions

---

## Variable flavors in detail

### Simply-expanded (:=)

The right-hand side is evaluated exactly once when the line is parsed.
Result is stored as a plain string. Subsequent changes to referenced
variables do not affect the stored value.

```makefile
x := foo
y := $(x) bar   # y is "foo bar"
x := later       # y is still "foo bar"
```

Use := by default. It is faster and avoids infinite recursion.

### Recursively-expanded (=)

The right-hand side is stored unevaluated. It is expanded every time
the variable is referenced. This means the value can pick up changes
to other variables made after the assignment.

```makefile
CFLAGS = $(includes) -Wall    # includes evaluated later, at each use
```

Use = only when the RHS must reference a variable that will be defined
later in the Makefile. Misuse can create infinite recursion if a variable
references itself.

### Conditional (?=)

Sets the variable only if it has no value (not set by environment, CLI, or
an earlier assignment). Correct way to provide user-overridable defaults.

```makefile
BUILD_TYPE ?= debug    # user can override: make BUILD_TYPE=release
```

### Append (+=)

Appends text to an existing variable. Inherits the flavor of the existing
variable. If the variable was not previously defined, += behaves like =.

```makefile
CFLAGS  := -Wall
CFLAGS  += -Wextra    # CFLAGS is now "-Wall -Wextra"; still simply-expanded
```

### Shell assign (!=)

Runs the right-hand side as a shell command and stores the output.
Evaluated once at parse time. Trailing newlines are removed.

```makefile
kernel_ver != uname -r
```

---

## Naming conventions detail

From GNU Make Manual Ch. 6:

"It is traditional to use upper case letters in variable names, but we
recommend using lower case letters for variable names that serve internal
purposes in the makefile, and reserving upper case for parameters that
control implicit rules or that the user is likely to want to override on
the command line."

From GNU Coding Standards 16.3:

"Append FLAGS to the program-name variable name to get the options
variable name -- for example, BISONFLAGS. (The name CFLAGS is an
exception to this rule, but we keep it because it is standard.)"

Variable names may contain any characters except :, #, =, and
leading or trailing whitespace. However, names with characters other
than letters, numbers, and underscores should be avoided because some
shells cannot pass them through the environment to sub-make.

---

## The ALL_CFLAGS pattern (GNU Coding Standards 16.3)

This is the correct way to have mandatory flags that survive user override:

```makefile
# User can set CFLAGS freely, e.g.: make CFLAGS="-O2 -DNDEBUG"
CFLAGS = -g

# Internal required flags
_internal_cflags := -I$(srcdir)/include -I$(builddir)

# Combined: internal flags first, CFLAGS last so user can override anything
ALL_CFLAGS = $(_internal_cflags) $(CFLAGS)

.c.o:
	$(CC) -c $(CPPFLAGS) $(ALL_CFLAGS) $<
```

The -g in CFLAGS is the default recommendation but users can override it.
Options that are required for correct compilation go in _internal_cflags,
not in CFLAGS.

---

## Environment and override priority

From GNU Make Manual Ch. 6:

Override priority from lowest to highest:

1. Default value (inside Makefile, with =, :=, or ?=)
2. Value from environment (inherited when make starts)
3. Value set in Makefile (overrides environment unless -e flag used)
4. Value on command line: make VAR=value (highest; cannot be overridden
   by Makefile assignment, only by override directive)

The override directive allows a Makefile assignment to take priority
over CLI:

```makefile
override CFLAGS += -Wall    # appended even if user set CFLAGS on CLI
```

Use sparingly. It prevents users from customizing the build.

---

## Target-specific variables (GNU Make Manual Ch. 6.11)

A variable can be set for a specific target and its prerequisites only:

```makefile
foo.o: CFLAGS += -O2
foo.o: foo.c
	$(CC) -c $(CFLAGS) $< -o $@
```

The value of CFLAGS inside foo.o's recipe includes -O2 even if the
global CFLAGS does not. This scope does not propagate to other targets.

The private keyword restricts a target-specific variable from propagating
to prerequisites:

```makefile
prog: private CFLAGS += -DDEBUG
```

---

## Exporting to sub-make (GNU Make Manual Ch. 5.7)

Variables defined in a Makefile are not automatically passed to
child make processes. Use export to make them available:

```makefile
export CC CXX BUILD_TYPE

# Or export with value
export DESTDIR = /tmp/staging
```

export without a variable name exports all variables:

```makefile
export    # exports everything; generally not recommended
```

Variables passed on the command line are always exported to sub-makes
automatically.

MAKEFLAGS is automatically passed to sub-makes and contains the flags
from the parent invocation (such as -j for parallel jobs).

---

## Common mistakes

Using = instead of := for $(shell ...) calls:

```makefile
# Wrong: shell runs every time SRCS is referenced
SRCS = $(shell find src -name '*.c')

# Right: shell runs once at parse time
SRCS := $(shell find src -name '*.c')
```

Trying to use $@ in a prerequisite list:

```makefile
# Wrong: $@ has no value in prerequisite context
foo.o: $@.c    # does not work

# Right: spell it out
foo.o: foo.c
```

Forgetting that += on an undefined variable acts like =, not :=:

```makefile
SRCS += main.c     # SRCS is recursively-expanded if not previously defined
SRCS := $(SRCS)    # freeze it to simply-expanded if needed
```
