# Monorepo root Makefile -- GNU-style recursive make
# Covers a copyable recursive root Makefile for multi-service trees that delegate to child Makefiles with `$(MAKE) -C`.
# Source: GNU Make Manual + GNU Coding Standards
#
# Assumed layout:
#   Makefile              this file
#   config/make/
#       toolchain.mk      CC, CXX, AR, tool detection
#       flags.mk          CFLAGS, LDFLAGS composition
#   services/
#       api/Makefile
#       worker/Makefile
#   lib/
#       common/Makefile

# --------------------------------------------------------------------------
# 1. Shell
# --------------------------------------------------------------------------
SHELL = /bin/sh
.SUFFIXES:
.DEFAULT_GOAL := all

# --------------------------------------------------------------------------
# 2. Include shared config
# - prefix suppresses errors when files are absent on a clean tree
# --------------------------------------------------------------------------
-include config/make/toolchain.mk
-include config/make/flags.mk

# --------------------------------------------------------------------------
# 3. Export -- variables passed to all child make processes
# Export only what children need; avoid polluting their namespace.
# CLI variables are exported automatically; no need to list them here.
# --------------------------------------------------------------------------
export CC CXX AR RANLIB
export CFLAGS CPPFLAGS LDFLAGS
export BUILD_TYPE VERSION

# --------------------------------------------------------------------------
# 4. Parameters with defaults
# CLI override: make BUILD_TYPE=release
# --------------------------------------------------------------------------
BUILD_TYPE ?= debug
VERSION    ?= 0.0.0

prefix        ?= /usr/local
exec_prefix   ?= $(prefix)
bindir        ?= $(exec_prefix)/bin

# --------------------------------------------------------------------------
# 5. Service and library lists
# --------------------------------------------------------------------------
libs     := common
services := api worker

# --------------------------------------------------------------------------
# 6. Phony
# --------------------------------------------------------------------------
.PHONY: all build test install clean distclean help
.PHONY: $(libs) $(services)

# --------------------------------------------------------------------------
# 7. Top-level targets
# --------------------------------------------------------------------------
all: build

build: $(libs) $(services)

# libs must be built before services
$(libs):
	$(MAKE) -C lib/$@ build

$(services): $(libs)
	$(MAKE) -C services/$@ build

test:
	@for svc in $(services); do \
	    echo "=== $$svc ==="; \
	    $(MAKE) -C services/$$svc check; \
	done

install:
	@for svc in $(services); do \
	    $(MAKE) -C services/$$svc install prefix=$(prefix); \
	done

clean:
	@for svc in $(services); do $(MAKE) -C services/$$svc clean; done
	@for lib  in $(libs);     do $(MAKE) -C lib/$$lib     clean; done

distclean: clean
	@for svc in $(services); do $(MAKE) -C services/$$svc distclean; done
	@for lib  in $(libs);     do $(MAKE) -C lib/$$lib     distclean; done

help:
	@echo "Targets:  all build test install clean distclean"
	@echo "Services: $(services)"
	@echo "Libs:     $(libs)"
	@echo ""
	@echo "Overrides:"
	@echo "  make BUILD_TYPE=release"
	@echo "  make CC=clang"
	@echo "  make install prefix=/opt/myproject"

# --------------------------------------------------------------------------
# config/make/toolchain.mk (example content)
# --------------------------------------------------------------------------
# CC               = gcc
# CXX              = g++
# AR               = ar
# RANLIB           = ranlib
# INSTALL          = install
# INSTALL_PROGRAM  = $(INSTALL)
# INSTALL_DATA     = $(INSTALL) -m 644

# --------------------------------------------------------------------------
# config/make/flags.mk (example content)
# --------------------------------------------------------------------------
# _cflags_debug   := -g -O0 -fsanitize=address
# _cflags_release := -O2 -DNDEBUG
#
# CFLAGS    = -Wall -Wextra -std=c11 $(_cflags_$(BUILD_TYPE))
# CPPFLAGS  = -I$(CURDIR)/lib/common/include
# LDFLAGS   =
