FILESEXTRAPATHS_prepend_edison := "${THISDIR}/files:"

# Use the stable version of linux
LINUX_VERSION = "3.10.17"
SRC_URI = " \
    git://github.com/01org/edison-linux.git;protocol=git;branch=edison-${LINUX_VERSION};nocheckout=1;name=machine \
    file://defconfig \
    file://0001-add-gcc5-support.patch \
    "
SRCREV_machine = "0806da4730c0b863078f9d353272863fdf0f780d"

# Patch to avoid exposing mmc partitions
SRC_URI_append_edison = " file://do_not_expose_mmc_boot_partitions.patch"

inherit kernel-resin

# Fix the KERNEL_OUTPUT variable
# Bug introduced in a6f52930a68d8462e23486d51cdda715072dd752
KERNEL_OUTPUT = "arch/x86/boot/${KERNEL_IMAGETYPE}"

# GCC now defaults to -std=gnu11.
#   commit b2601928b5bf34a817b5a9a2a371c476018e634d
#   Author: mpolacek <mpolacek@138bc75d-0d04-0410-961f-82ee72b054a4>
#   Date:   Wed Oct 15 10:08:00 2014 +0000
# GNU 90 and C99 have different "extern inline" behavior.
# Compile thie kernel version with -std=gnu89 for backwards compatibility.
# Ref.: https://gcc.gnu.org/bugzilla/show_bug.cgi?format=multiple&id=63592
KERNEL_CC_append = " -std=gnu89"

# Deactivate AUDIT to avoid different kernel errors
RESIN_CONFIGS_append = " noaudit"
RESIN_CONFIGS[noaudit] = "CONFIG_AUDIT=n"
