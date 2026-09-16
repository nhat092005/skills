# GNU-style Makefile for a C/C++ project
# Covers a copyable GNU-style project skeleton with standard variables, phony targets, install rules, and dependency generation.
# Source: GNU Make Manual + GNU Coding Standards
#
# Copy to project root and adjust the CONFIG section.
# Override from CLI: make CC=clang CFLAGS="-O2 -DNDEBUG"
# Staged install:    make install DESTDIR=/tmp/staging

# --------------------------------------------------------------------------
# 1. Shell and suffix list (GNU Make Manual 16.1)
# --------------------------------------------------------------------------
SHELL = /bin/sh

.SUFFIXES:
.SUFFIXES: .c .cc .o .a

.DEFAULT_GOAL := all

# --------------------------------------------------------------------------
# 2. Config -- adjust these
# --------------------------------------------------------------------------
PACKAGE   = myproject
VERSION   = 0.1.0

prefix        = /usr/local
exec_prefix   = $(prefix)
bindir        = $(exec_prefix)/bin
libdir        = $(exec_prefix)/lib
includedir    = $(prefix)/include
sysconfdir    = $(prefix)/etc
datadir       = $(prefix)/share
mandir        = $(prefix)/man/man1

src_dir   = src
build_dir = build
bin_dir   = bin

# --------------------------------------------------------------------------
# 3. Tools -- always via variables, never hardcode (GNU Coding Standards 16.2)
# --------------------------------------------------------------------------
CC               = gcc
CXX              = g++
AR               = ar
RANLIB           = ranlib
INSTALL          = install
INSTALL_PROGRAM  = $(INSTALL)
INSTALL_DATA     = $(INSTALL) -m 644

# --------------------------------------------------------------------------
# 4. Flags
#
# CFLAGS is user-facing; never put mandatory options here.
# Mandatory options go into _cflags_required.
# ALL_CFLAGS combines both with CFLAGS last so users can override.
# (GNU Coding Standards 16.3)
# --------------------------------------------------------------------------
CFLAGS    = -g -Wall -Wextra -std=c11
CPPFLAGS  =
LDFLAGS   =
LDLIBS    =

_cflags_required := -I$(src_dir)
ALL_CFLAGS        = $(_cflags_required) $(CFLAGS)

# --------------------------------------------------------------------------
# 5. Sources and objects
# --------------------------------------------------------------------------
srcs := $(wildcard $(src_dir)/*.c)
objs := $(patsubst $(src_dir)/%.c,$(build_dir)/%.o,$(srcs))
deps := $(objs:.o=.d)

target := $(bin_dir)/$(PACKAGE)

# --------------------------------------------------------------------------
# 6. Phony targets (all non-file targets must be declared here)
# --------------------------------------------------------------------------
.PHONY: all install uninstall clean distclean mostlyclean check dist TAGS help

# --------------------------------------------------------------------------
# 7. Build rules
# --------------------------------------------------------------------------
all: $(target)

$(target): $(objs)
	@mkdir -p $(@D)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

# Pattern rule: .c -> .o with automatic dependency tracking
$(build_dir)/%.o: $(src_dir)/%.c
	@mkdir -p $(@D)
	$(CC) -c $(CPPFLAGS) $(ALL_CFLAGS) -MMD -MP $< -o $@

# Include auto-generated .d files; - prefix suppresses errors on first build
-include $(deps)

# --------------------------------------------------------------------------
# 8. Install targets (GNU Coding Standards 16.4 and 16.6)
# --------------------------------------------------------------------------
install: all
	@mkdir -p $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) $(target) $(DESTDIR)$(bindir)/$(PACKAGE)

uninstall:
	rm -f $(DESTDIR)$(bindir)/$(PACKAGE)

# --------------------------------------------------------------------------
# 9. Clean targets
# clean:     remove build artifacts; keep config and distributed files
# distclean: remove everything configure or build produced
# mostlyclean: like clean but spare expensive-to-rebuild files
# --------------------------------------------------------------------------
clean:
	rm -f $(objs) $(deps) $(target)
	@rmdir $(build_dir) $(bin_dir) 2>/dev/null; true

distclean: clean
	rm -f config.h config.log config.status
	rm -rf autom4te.cache

mostlyclean: clean

# --------------------------------------------------------------------------
# 10. Check / test
# --------------------------------------------------------------------------
check: all
	@echo "Running tests..."
	# replace with actual runner, e.g.: ./tests/run_tests.sh

# --------------------------------------------------------------------------
# 11. Distribution tarball
# Subdir inside tar named package-version (GNU Coding Standards 16.6)
# --------------------------------------------------------------------------
dist:
	@distdir=$(PACKAGE)-$(VERSION); \
	mkdir -p $$distdir; \
	cp -r $(src_dir) Makefile README $$distdir/; \
	tar czf $$distdir.tar.gz $$distdir; \
	rm -rf $$distdir; \
	echo "Created $$distdir.tar.gz"

# --------------------------------------------------------------------------
# 12. Tags
# --------------------------------------------------------------------------
TAGS:
	etags $(srcs) $(wildcard $(src_dir)/*.h)

# --------------------------------------------------------------------------
# 13. Help
# --------------------------------------------------------------------------
help:
	@echo "$(PACKAGE) $(VERSION)"
	@echo ""
	@echo "Targets:"
	@echo "  all          Build $(PACKAGE) (default)"
	@echo "  install      Install to prefix (default $(prefix))"
	@echo "  uninstall    Remove installed files"
	@echo "  check        Run tests"
	@echo "  clean        Remove build artifacts"
	@echo "  distclean    Remove everything configure/build produced"
	@echo "  dist         Create $(PACKAGE)-$(VERSION).tar.gz"
	@echo "  TAGS         Generate etags"
	@echo ""
	@echo "Overrides:"
	@echo "  make CC=clang CFLAGS='-O2 -DNDEBUG'"
	@echo "  make install prefix=/opt/$(PACKAGE)"
	@echo "  make install DESTDIR=/tmp/staging"
