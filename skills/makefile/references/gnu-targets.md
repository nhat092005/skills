# GNU Standard Targets and Installation -- Deep Reference

Covers standard GNU targets, installation directory variables, and staged install rules such as `DESTDIR`.

Source: GNU Coding Standards, Makefile Conventions, Chapter 16
        GNU Make Manual

---

## Standard targets in detail (GNU Coding Standards 16.6)

### all

Compile the entire program. This is the default target.
It need not rebuild documentation files; Info files should normally
be included in the distribution, and DVI files only built when asked.

### install

Compile and copy executables, libraries, and other files to where they
will reside for actual use. If there is a simple test to verify a program
is properly installed, this target should run that test.

The install target must create all directories where files are to be
installed, including $(prefix), $(exec_prefix), and all subdirectories.

Use - before any command that installs a man page to ignore errors from
systems that do not have the Unix man documentation system installed.

### uninstall

Delete all files that the install target would create. Do not delete
files that would be created by building, only files placed by install.

### clean

Delete files from the current directory that are normally created by
building the program. Do not delete files that record the configuration.
Preserve files that could be made by building but normally are not because
the distribution comes with them.

Delete .dvi files here if they are not part of the distribution.

### distclean

Delete all files in the current directory that are created by configuring
or building the program. After make distclean, the only files remaining
should be those that were in the source distribution.

### mostlyclean

Like clean, but may keep a few files that people normally do not want
to recompile. Example: GCC keeps libgcc.a in mostlyclean because
recompiling it is rarely necessary and takes a long time.

### realclean

Delete everything that can be reconstructed using this Makefile.
This typically includes everything deleted by distclean, plus:
C source files produced by Bison, tags tables, Info files, and so on.

Exception: make realclean must not delete configure even if configure
can be remade from the Makefile. More generally, realclean should not
delete anything required to run configure and begin building.

### check

Perform self-tests. The user must build the program before running tests
but need not install it. Write self-tests so they work when the program
is built but not installed.

### installcheck

Perform installation tests. The user must build and install the program
before running these tests. Do not assume $(bindir) is in PATH.

### installdirs

Create the directories where files are installed, and their parent
directories. This is useful for separating directory creation from file
copying. Example:

```makefile
installdirs:
	mkdir -p $(DESTDIR)$(bindir) $(DESTDIR)$(libdir) $(DESTDIR)$(mandir)
```

Note: mkdir -p is used here in an example but the GNU Coding Standards
say not to rely on it in portable Makefiles. Use mkinstalldirs from the
Texinfo package instead if you need portability across all POSIX systems.

### dist

Create a distribution tar file. The tar file should be set up so that
file names inside it start with a subdirectory named package-version.

Example: GCC version 1.40 unpacks into gcc-1.40/

The dist target should explicitly depend on all non-source files that
are in the distribution to make sure they are up to date.

### TAGS

Update a tags table for this program (for use with editors like Emacs
and vi).

### info

Generate any Info files needed. Example:

```makefile
info: foo.info

foo.info: foo.texi chap1.texi chap2.texi
	$(MAKEINFO) $(srcdir)/foo.texi
```

### dvi

Generate DVI files for all Texinfo documentation.

---

## .PHONY declaration

Every target that does not produce a file of the same name must be
declared in .PHONY. This prevents make from confusing the target with
a file, and forces the recipe to run even if a file of that name exists.

```makefile
.PHONY: all install uninstall clean distclean mostlyclean realclean
.PHONY: check installcheck installdirs dist TAGS info dvi help
```

---

## Installation directory variables in detail (GNU Coding Standards 16.5)

Installation directories should always be named by variables so it is
easy to install in a nonstandard place.

### Root prefixes

```makefile
prefix      = /usr/local
exec_prefix = $(prefix)
```

prefix is used for directories containing architecture-independent files.
exec_prefix is used for directories containing machine-specific files
such as executables and libraries. By default it equals $(prefix).

### Executable directories

```makefile
bindir     = $(exec_prefix)/bin     # programs that users run
sbindir    = $(exec_prefix)/sbin    # programs for system administrators only
libexecdir = $(exec_prefix)/libexec # programs run by other programs, not users
```

### Data directories

```makefile
datadir       = $(prefix)/share      # architecture-independent read-only data
sysconfdir    = $(prefix)/etc        # host-specific config; ASCII text only
sharedstatedir = $(prefix)/com       # architecture-independent modifiable data
localstatedir  = $(prefix)/var       # host-specific modifiable data
```

Do not install executables in $(sysconfdir) or $(datadir).
Do not install files modified during normal operation in $(sysconfdir);
those belong in $(localstatedir).

### Library and header directories

```makefile
libdir     = $(exec_prefix)/lib     # object files and libraries; not executables
includedir = $(prefix)/include      # C headers for user programs
```

### Documentation directories

```makefile
infodir  = $(prefix)/info
mandir   = $(prefix)/man/man1       # include section suffix
manext   = .1
srcdir   =                          # set by configure
```

---

## DESTDIR -- staged installs (GNU Coding Standards 16.4)

DESTDIR is prepended to every installation path. It allows building a
staged install tree, which is essential for packaging tools (rpm, deb,
stow) and for users who want to review what a package installs before
placing it in the real system.

```makefile
install: all
	$(INSTALL_PROGRAM) myprog $(DESTDIR)$(bindir)/myprog
	$(INSTALL_DATA) myprog.conf $(DESTDIR)$(sysconfdir)/myprog.conf
	$(INSTALL_DATA) myprog.1 $(DESTDIR)$(mandir)/myprog$(manext)
```

DESTDIR is not defined in the Makefile itself. Users pass it on the
command line:

    make install DESTDIR=/tmp/staging

The GNU Coding Standards state: "We strongly recommend GNU packages
support DESTDIR, though it is not an absolute requirement."

---

## Install command categories (GNU Coding Standards 16.7)

Use $(INSTALL_PROGRAM) for all executables.
Use $(INSTALL_DATA) for all non-executables (data, headers, man pages,
config files, libraries that are not executable).

Always use a file name, not a directory name, as the second argument
of the installation commands. Use a separate command for each file.

```makefile
# Correct: explicit file names
$(INSTALL_PROGRAM) foo $(DESTDIR)$(bindir)/foo
$(INSTALL_PROGRAM) bar $(DESTDIR)$(bindir)/bar

# Wrong: directory as second argument (not portable)
$(INSTALL_PROGRAM) foo bar $(DESTDIR)$(bindir)/
```

---

## Utilities allowed in Makefiles (GNU Coding Standards 16.2)

Write Makefile commands and shell scripts to run under sh (Bourne shell
or POSIX shell). Do not use any special features of ksh or bash.

These utilities may be used unconditionally in build and install rules:

    cat  cmp  cp  echo  egrep  expr  grep
    ln   mkdir  mv  pwd  rm  rmdir  sed  test  touch

Compilers and related programs should be invoked through make variables:

    $(AR) $(BISON) $(CC) $(FLEX) $(INSTALL) $(LD) $(LEX)
    $(MAKE) $(MAKEINFO) $(RANLIB) $(TEXI2DVI) $(YACC)

If you use ranlib, arrange to ignore errors from it and print a message
telling the user that failure of ranlib does not mean a problem.

If you use symbolic links, implement a fallback for systems without them.

It is acceptable to use other utilities in Makefile portions intended
only for specific systems where those utilities are known to exist.
