UBOOT_KCONFIG_SUPPORT = "1"

inherit resin-u-boot

RESIN_BOOT_PART = "7"
RESIN_DEFAULT_ROOT_PART = "8"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://0001-u-boot-env-Add-the-ability-to-merge-the-saved-env-with-the-default.patch"
