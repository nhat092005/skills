# Kbuild Makefile -- Linux kernel out-of-tree module
# Covers a copyable out-of-tree kernel module Makefile with the userspace wrapper and Kbuild section split.
# Source: Documentation/kbuild/makefiles.txt
#
# Build:   make -C /lib/modules/$(uname -r)/build M=$(PWD) modules
# Install: make -C /lib/modules/$(uname -r)/build M=$(PWD) modules_install
# Clean:   make -C /lib/modules/$(uname -r)/build M=$(PWD) clean

# --------------------------------------------------------------------------
# When invoked from userspace, KERNELRELEASE is not set.
# Redirect into the kernel build system which will re-read this Makefile
# with KERNELRELEASE set, at which point the kbuild section below applies.
# --------------------------------------------------------------------------
KERNELDIR ?= /lib/modules/$(shell uname -r)/build

ifeq ($(KERNELRELEASE),)

.PHONY: modules modules_install clean

modules:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

modules_install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install

clean:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean

else

# --------------------------------------------------------------------------
# Kbuild section -- read by the kernel build system
# --------------------------------------------------------------------------

# Single-file module:
obj-m := mydriver.o

# Multi-file module -- uncomment and adjust:
# obj-m          := mydriver.o
# mydriver-y     := main.o hw.o irq.o
# mydriver-$(CONFIG_MYDRIVER_DEBUG) += debug.o

# Compilation flags for this Makefile only.
# ccflags-y replaces the deprecated EXTRA_CFLAGS.
ccflags-y := -DMYDRIVER_VERSION=\"1.0.0\"
ccflags-$(CONFIG_MYDRIVER_DEBUG) += -DDEBUG

# Per-file flags (literal filename):
# CFLAGS_main.o = -O0

endif
