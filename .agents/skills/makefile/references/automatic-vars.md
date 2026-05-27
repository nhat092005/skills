# Automatic Variables -- Deep Reference

Covers recipe-scoped automatic variables, directory/file variants, and the common rule mistakes around them.

Source: GNU Make Manual, Chapter 10

---

## Scope restriction

Automatic variables have values computed afresh for each rule that is
executed, based on the target and prerequisites of that rule.

They are only valid inside a recipe. They cannot be used in:
- The target list of a rule
- The prerequisite list of a rule

A common mistake is attempting to use $@ within the prerequisites list.
This does not work. GNU Make does provide secondary expansion as a
special feature that allows automatic variable values to be used in
prerequisite lists, but that is an advanced and rarely needed feature.

---

## Complete variable table

### Single file name variables

| Variable | Value |
|----------|-------|
| $@       | The file name of the target of the rule. If the target is an archive member, $@ is the name of the archive file. |
| $<       | The name of the first prerequisite. |
| $*       | The stem with which an implicit rule matches. If the target is dir/a.foo.b and the pattern is a.%.b, the stem is dir/foo. The stem is useful for constructing related file names. |
| $%       | The target member name when the target is an archive member. For example, if the target is foo.a(bar.o), $% is bar.o and $@ is foo.a. $% is empty when the target is not an archive member. |

### List variables

| Variable | Value |
|----------|-------|
| $^       | The names of all prerequisites, with spaces between them. For archive members, only the named member is used. Duplicates are removed: each prerequisite appears only once regardless of how many times it was listed. Order-only prerequisites are not included. |
| $+       | Like $^ but prerequisites listed more than once are duplicated in the order they were listed. Mainly useful for linking where order and repetition may matter. |
| $|       | The names of all order-only prerequisites, with spaces between them. |

---

## Directory and file variants

Each of the seven variables above has two variants: one that gives just
the directory part and one that gives just the file part within the
directory. These are formed by appending D or F respectively.

| Variant | Value |
|---------|-------|
| $(@D)   | Directory part of $@. Omits the trailing slash. If $@ is /foo/bar.o, $(@D) is /foo. If there is no slash, $(@D) is . |
| $(@F)   | File-within-directory part of $@. If $@ is /foo/bar.o, $(@F) is bar.o. |
| $(*D)   | Directory part of the stem $*. |
| $(*F)   | File part of the stem $*. |
| $(%D)   | Directory part of $%. |
| $(%F)   | File part of $%. |
| $(<D)   | Directory part of $<. |
| $(<F)   | File part of $<. |
| $(^D)   | List of directory parts of $^. |
| $(^F)   | List of file parts of $^. |
| $(+D)   | List of directory parts of $+. |
| $(+F)   | List of file parts of $+. |

The functions dir and notdir can produce similar results but the D
variants omit the trailing slash that dir always includes.

---

## Usage in pattern rules

Pattern rules are the primary context for automatic variables.
The % character matches any nonempty string (the stem).

```makefile
# Compile .c files into .o files in a build directory
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) -c $(CPPFLAGS) $(ALL_CFLAGS) $< -o $@
```

Explanation:
- $(@D) is the directory part of the target; used to create the output
  directory before writing to it.
- $< is the first prerequisite (the .c file).
- $@ is the full target path (the .o file).

```makefile
# Link all objects into a binary
$(BIN_DIR)/myprog: $(objs)
	@mkdir -p $(@D)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@
```

Explanation:
- $^ is the complete list of object files, deduplicated.
- $@ is the binary output path.

---

## The stem $* in pattern rules

$* is the stem that % matched. If the target is src/net/tcp.o and the
pattern is src/%.o, then $* is net/tcp.

Useful for building related names:

```makefile
%.tab.c %.tab.h: %.y
	bison -d $<
```

Inside this recipe, $* is the base name (without .y) and $@ cycles
through %.tab.c and %.tab.h.

---

## Order-only prerequisites and $|

Order-only prerequisites appear after a | in the prerequisite list.
They ensure the directory or file exists before building the target
but do not cause the target to be rebuilt if they change.

```makefile
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) -c $< -o $@

$(BUILD_DIR):
	mkdir $(BUILD_DIR)
```

$| in the recipe contains the order-only prerequisites ($(BUILD_DIR)).

---

## Archive member targets and $%

When the target is an archive member such as foo.a(bar.o):

- $@ is foo.a (the archive file)
- $% is bar.o (the member)

```makefile
foo.a(bar.o): bar.o
	$(AR) r $@ $<
```

$% is empty when the target is not an archive member.

---

## Common mistakes

### Using $@ in a prerequisite list

```makefile
# Wrong: $@ has no value in prerequisite context
$(BUILD_DIR)/%.o: $(@D)/%.c
	$(CC) -c $< -o $@

# Correct: use the stem or an explicit path
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $< -o $@
```

### Forgetting $(@D) when writing to a new directory

```makefile
# Wrong: fails if $(BUILD_DIR)/subdir does not exist
$(BUILD_DIR)/subdir/%.o: %.c
	$(CC) -c $< -o $@

# Correct: create the directory first
$(BUILD_DIR)/subdir/%.o: %.c
	@mkdir -p $(@D)
	$(CC) -c $< -o $@
```

### Confusing $^ and $+

Use $^ when you want each prerequisite exactly once (most cases).
Use $+ when you need duplicates preserved, such as when linking with
libraries that have circular dependencies and must be listed multiple times.
