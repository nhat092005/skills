# Kbuild Deep Reference

Covers Kbuild goal definitions, flag variables, helper functions, clean behavior, and architecture-level Makefile rules.

Source: Linux kernel Kbuild documentation

## Table of contents

1. The five parts of the kernel Makefiles
2. Goal definitions in detail
3. Descending into subdirectories
4. Compilation flags in detail
5. Dependency tracking
6. Special rules
7. CC support functions
8. LD support functions
9. Host program support
10. Clean infrastructure
11. Architecture Makefile variables
12. if_changed and custom commands
13. Kbuild variables section
14. Makefile language notes from the kernel

---

## The five parts of the kernel Makefiles (section 1)

    Makefile                  the top Makefile
    .config                   the kernel configuration file
    arch/$(ARCH)/Makefile     the arch Makefile
    scripts/Makefile.*        common rules for all kbuild Makefiles
    kbuild Makefiles          one per subdirectory, about 500 total

The top Makefile reads .config and builds two products: vmlinux (the
resident kernel image) and modules. It recursively descends into
subdirectories; which subdirectories are visited depends on the
kernel configuration.

---

## Goal definitions in detail (section 3.1 to 3.5)

### obj-y: built-in

```makefile
obj-y += foo.o
```

foo.o will be built from foo.c or foo.S. All obj-y files are compiled
and then merged into built-in.a using "$(AR) rcSTP". This thin archive
is later linked into vmlinux by scripts/link-vmlinux.sh.

Link order in obj-y is significant. module_init() and __initcall
functions are called during boot in the order they appear. Changing
link order can change the order in which SCSI controllers are detected
and therefore how disks are numbered.

Duplicates in obj-y are allowed; only the first instance is linked into
built-in.a, subsequent instances are ignored.

### obj-m: loadable modules

```makefile
obj-m += mymodule.o
```

For a single-file module, just list the .o in obj-m. For a multi-file
module, list the module .o in obj-m and then list the constituent files
in a variable named after the module with -y suffix:

```makefile
obj-m         += isdn.o
isdn-y        := isdn_net_lib.o isdn_v110.o isdn_common.o
```

kbuild compiles the objects in isdn-y and then runs "$(LD) -r" to link
them into isdn.o.

### obj-$(CONFIG_FOO): config-driven

This is the standard pattern in the kernel:

```makefile
obj-$(CONFIG_ISDN_I4L)         += isdn.o
obj-$(CONFIG_ISDN_PPP_BSDCOMP) += isdn_bsdcomp.o
```

$(CONFIG_ISDN_I4L) expands to y, m, or nothing. If nothing, the file is
not compiled and not linked. This means kbuild can completely skip the
file with zero cost.

Optional components of a composite object:

```makefile
obj-$(CONFIG_EXT2_FS) += ext2.o
ext2-y := balloc.o dir.o file.o ialloc.o inode.o ioctl.o
ext2-$(CONFIG_EXT2_FS_XATTR) += xattr.o xattr_user.o xattr_trusted.o
```

xattr.o and friends are only compiled if both CONFIG_EXT2_FS and
CONFIG_EXT2_FS_XATTR are set.

### lib-y: library archives

```makefile
lib-y := delay.o
```

Objects in lib-y are combined into lib.a for that directory. If an
object appears in both obj-y and lib-y, it is not duplicated in lib.a
since obj-y already makes it accessible. Use of lib-y is normally
restricted to lib/ and arch/*/lib.

---

## Descending into subdirectories (section 3.6)

A Makefile is responsible only for building objects in its own directory.
To delegate to a subdirectory, add its name with a trailing slash:

```makefile
# fs/Makefile
obj-$(CONFIG_EXT2_FS) += ext2/
```

kbuild automatically invokes make recursively in ext2/ when
CONFIG_EXT2_FS is y or m. If CONFIG_EXT2_FS is neither, kbuild skips
the directory entirely with no overhead.

The Makefile in the subdirectory specifies what is modular and what is
built-in. The parent Makefile only decides whether to descend.

---

## Compilation flags in detail (section 3.7)

### ccflags-y, asflags-y, ldflags-y

These flags apply only to the kbuild Makefile where they are assigned.
They are used for all cc, as, and ld invocations in that Makefile during
a recursive build.

The deprecated names EXTRA_CFLAGS, EXTRA_AFLAGS, EXTRA_LDFLAGS are still
supported but must not be used in new code.

ccflags-y is necessary because the top Makefile owns KBUILD_CFLAGS and
uses it for the entire tree. A subdirectory cannot safely modify
KBUILD_CFLAGS without affecting other directories.

```makefile
# drivers/acpi/acpica/Makefile
ccflags-y                    := -Os -D_LINUX -DBUILDING_ACPICA
ccflags-$(CONFIG_ACPI_DEBUG) += -DACPI_DEBUG_OUTPUT

# arch/sparc/kernel/Makefile
asflags-y := -ansi

# arch/cris/boot/compressed/Makefile
ldflags-y += -T $(srctree)/$(src)/decompress_$(arch-y).lds
```

### subdir-ccflags-y, subdir-asflags-y

Like ccflags-y and asflags-y but the flags also take effect in all
subdirectories. subdir-* flags are added to the command line before the
non-subdir variants.

```makefile
subdir-ccflags-y := -Werror
```

### CFLAGS_file.o, AFLAGS_file.o

Per-file flags. The filename is literal, not a variable.

```makefile
# drivers/scsi/Makefile
CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS

# arch/arm/kernel/Makefile
AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
AFLAGS_crunch-bits.o := -Wa,-mcpu=ep9312
AFLAGS_iwmmxt.o      := -Wa,-mcpu=iwmmxt
```

---

## Dependency tracking (section 3.9)

Kbuild tracks dependencies on:

1. All prerequisite files (both .c and .h)
2. CONFIG_ options used in all prerequisite files
3. The command line used to compile the target

If any compiler option changes, all affected files are recompiled.
This is handled automatically; no manual dependency files are needed.

---

## Special rules (section 3.10)

Special rules are used when kbuild infrastructure does not provide the
required support; for example, generating header files during the build
or building architecture-specific boot images.

kbuild does not execute in the directory where the Makefile is located.
All special rules must use relative paths:

    $(src)  relative path to the directory where the Makefile is located
            Use for source files that are not generated.

    $(obj)  relative path to the directory where generated files go.
            Use for generated files and compilation targets.

```makefile
# drivers/scsi/Makefile
$(obj)/53c8xx_d.h: $(src)/53c7,8xx.scr $(src)/script_asm.pl
	$(CPP) -DCHIP=810 - < $< | $(src)/script_asm.pl > $@
```

$(kecho) echoes text to stdout except when make -s is used:

```makefile
$(obj)/vmImage: $(obj)/vmlinux.gz
	$(call if_changed,uimage)
	@$(kecho) 'Kernel: $@ is ready'
```

---

## CC support functions (section 3.11)

### cc-option

Check if $(CC) supports an option. A fallback option may be given as
the second argument. Uses KBUILD_CFLAGS for the check.

```makefile
# arch/x86/Makefile
cflags-y += $(call cc-option,-march=pentium-mmx,-march=i586)
```

If -march=pentium-mmx is supported, it is used; otherwise -march=i586.

### cc-option-yn

Returns y if $(CC) supports the option, n otherwise.

```makefile
# arch/ppc/Makefile
biarch := $(call cc-option-yn,-m32)
aflags-$(biarch) += -a32
cflags-$(biarch) += -m32
```

### cc-disable-warning

Returns the -Wno-* switch only if $(CC) actually accepts it. This is
needed because gcc 4.4 and later accept unknown -Wno-* options silently
and only warn about them if another warning is present in the file.

```makefile
KBUILD_CFLAGS += $(call cc-disable-warning,unused-but-set-variable)
```

### cc-ifversion

Evaluates to the fourth argument if the version expression is true,
or the fifth argument (if given) otherwise. Shell operators supported:
-eq, -ne, -lt, -le, -gt, -ge.

```makefile
# fs/reiserfs/Makefile
ccflags-y := $(call cc-ifversion,-lt,0402,-O1)
```

Version 0402 means gcc 4.2.

### cc-cross-prefix

Returns the first prefix in the list for which prefix$(CC) exists in
PATH. Useful for setting CROSS_COMPILE in arch Makefiles.

```makefile
# arch/m68k/Makefile
ifneq ($(SUBARCH),$(ARCH))
    ifeq ($(CROSS_COMPILE),)
        CROSS_COMPILE := $(call cc-cross-prefix,m68k-linux-gnu-)
    endif
endif
```

Recommended: only try to set CROSS_COMPILE when it is a cross-build
and CROSS_COMPILE is not already set.

### as-option

Check if $(CC) when compiling assembler files supports the option.

```makefile
# arch/sh/Makefile
cflags-y += $(call as-option,-Wa$(comma)-isa=$(isa-y),)
```

---

## LD support functions (section 3.12)

### ld-option

Check if $(LD) supports the supplied option.

```makefile
LDFLAGS_vmlinux += $(call ld-option,-X)
```

---

## Host program support (section 4)

Host programs are compiled for the build machine, not the target.
Used for code generators and config tools run during the build.

```makefile
# Simple single-file host program
hostprogs-y := bin2hex

# Composite host program
hostprogs-y   := lxdialog
lxdialog-objs := checklist.o lxdialog.o

# Host program flags
HOST_EXTRACFLAGS    += -I/usr/include/ncurses
HOSTCFLAGS_piggyback.o := -DKERNELBASE=$(KERNELBASE)
HOSTLDLIBS_qconf    := -L$(QTDIR)/lib
```

Host programs are built only when referenced as a prerequisite or listed
in $(always).

---

## Clean infrastructure (section 5)

"make clean" deletes files in $(hostprogs-y), $(hostprogs-m), $(always),
$(extra-y), and $(targets). Files matching *.[oas] and *.ko are deleted
everywhere in the source tree.

```makefile
# Extra files to delete
clean-files := crc32table.h generated_table.c

# Extra directories to delete (including all subdirs)
clean-dirs := $(objtree)/debian/

# Files to protect from make clean (top-level Kbuild only)
no-clean-files := $(bounds-file) $(offsets-file)

# Explicit subdirectory descent for clean (in arch Makefiles)
subdir- := compressed/

# archclean hook for boot Makefiles
archclean:
	$(Q)$(MAKE) $(clean)=arch/x86/boot
```

---

## Architecture Makefile variables (section 6.1)

These are set in arch/$(ARCH)/Makefile:

```makefile
# Generic linker flags for all invocations
LDFLAGS := -m elf_s390

# Extra linker flags for the final vmlinux link
LDFLAGS_vmlinux := -e stext

# objcopy flags
OBJCOPYFLAGS := -O binary

# Assembler flags
KBUILD_AFLAGS += -m64 -mcpu=ultrasparc

# Compiler flags
KBUILD_CFLAGS += $(cflags-y)

# Override kbuild defaults after top-level Makefile sets other flags
ARCH_CFLAGS   := -mstrict-align
ARCH_AFLAGS   := -mstrict-align
```

### Arch link order (section 6.4)

```makefile
# arch/sparc64/Makefile
core-y   += arch/sparc64/kernel/
libs-y   += arch/sparc64/prom/ arch/sparc64/lib/
drivers-$(CONFIG_OPROFILE) += arch/sparc64/oprofile/
```

Link order into vmlinux: head-y, init-y, core-y, libs-y, drivers-y, net-y

---

## if_changed and custom commands (section 6.7 and 6.8)

if_changed rebuilds the target if any prerequisite changed or if the
command line changed since the last invocation.

Every target using if_changed must be listed in $(targets).
The FORCE prerequisite is mandatory; forgetting it is a common mistake.

```makefile
targets += $(obj)/bzImage

$(obj)/bzImage: $(obj)/vmlinux.bin $(obj)/tools/build FORCE
	$(call if_changed,image)
	@echo 'Kernel: $@ is ready'
```

Custom command definition:

```makefile
quiet_cmd_image = BUILD   $@
      cmd_image = $(obj)/tools/build $(BUILDFLAGS) $(obj)/vmlinux.bin > $@
```

With KBUILD_VERBOSE=0 (the default), only the quiet form is shown:

    BUILD    arch/x86/boot/bzImage

Do not call if_changed more than once per target. It stores the
executed command in a .cmd file; multiple calls would overwrite it.
Extra whitespace after the comma in the call is a known mistake:

```makefile
# Wrong (note space after comma)
$(call if_changed, ld)

# Correct
$(call if_changed,ld)
```

---

## Kbuild variables section (section 8)

The top Makefile exports these variables for use in arch and kbuild files:

    VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION   kernel version components
    KERNELRELEASE    full version string such as 6.1.0-rc4
    ARCH             target architecture; default is host arch
    INSTALL_PATH     where arch Makefiles install the kernel image
    INSTALL_MOD_PATH prefix for module installation
    MODLIB           full path for module installation
    INSTALL_MOD_STRIP if set, strip modules after installing

---

## Makefile language notes from the kernel (section 9)

The kernel Makefiles use only documented features of GNU Make but use
many GNU extensions.

GNU Make has two assignment operators:
- := performs immediate evaluation; stores a string
- = is like a formula; stored unevaluated and expanded at each use

"There are some cases where = is appropriate. Usually, though, := is
the right choice." (Documentation/kbuild/makefiles.txt section 9)

The kernel Makefiles use a novel style of list building and manipulation
with few if statements, relying on CONFIG_-based variable expansion
instead of conditional blocks.
