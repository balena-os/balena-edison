UBOOT_KCONFIG_SUPPORT = "1"

inherit resin-u-boot

BALENA_BOOT_PART = "7"
BALENA_DEFAULT_ROOT_PART = "8"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://0001-u-boot-env-Add-the-ability-to-merge-the-saved-env-with-the-default.patch \
	file://0002-edison-Enable-CONFIG_CMD_SETEXPR.patch \
	file://0003-add-gcc8-header.patch \
"
