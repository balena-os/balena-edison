FILESEXTRAPATHS_append_edison := "${THISDIR}/files:"
SRC_URI_append_edison = " file://do_not_expose_mmc_boot_partitions.patch"

inherit kernel-resin

SRCREV_machine = "9097ab0ea160187c87b049c3cb92b87170f3bc24"

# Fix the KERNEL_OUTPUT variable
# Bug introduced in a6f52930a68d8462e23486d51cdda715072dd752
KERNEL_OUTPUT = "arch/x86/boot/${KERNEL_IMAGETYPE}"

