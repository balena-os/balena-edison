NOHDD_edison = "0"

inherit bootimg

# TODO
# This was already fixed in poky but fix was not backported to daisy
# To be removed in the future
do_bootimg[depends] += "virtual/kernel:do_deploy"
do_bootimg[depends] += "networkmanager:do_deploy"
do_bootimg[depends] += "resin-image:do_rootfs"

# Do not use legacy nor EFI BIOS
PCBIOS_edison = "0"

# Specify rootfs image type
IMAGE_FSTYPES_append_edison = " hddimg"

# We currently use ext3 rootfs partitions
IMAGE_TYPEDEP_hddimg = "ext3"

BOOTIMG_VOLUME_ID_edison = "resin-boot"

DEPENDS_append_edison = "\
    edison-dfu \
    btrfs-tools-native \
    dosfstools-native \
    e2fsprogs-native \
    "

IMAGE_INSTALL_append_edison = " packagegroup-edison"

IMAGE_POSTPROCESS_COMMAND_append_edison = " \
    define_labels; \
    deploy_bundle; \
    "

define_labels() {
    #Missing labels
    e2label ${DEPLOY_DIR_IMAGE}/resin-image-edison.ext3 ${RESIN_ROOTA_FS_LABEL}
    e2label ${DEPLOY_DIR_IMAGE}/resin-data.img ${RESIN_DATA_FS_LABEL}
}

deploy_bundle() {
    # Create an empty ext4 filesystem for our config partition
    RESIN_STATE_BLOCKS=${RESIN_STATE_SIZE}
    rm -rf ${DEPLOY_DIR_IMAGE}/resin-state.img
    dd if=/dev/zero of=${DEPLOY_DIR_IMAGE}/resin-state.img count=${RESIN_STATE_BLOCKS} bs=1024
    mkfs.ext4 -F -L "${RESIN_STATE_FS_LABEL}" ${DEPLOY_DIR_IMAGE}/resin-state.img

    mkdir -p ${DEPLOY_DIR_IMAGE}/resin-edison
    cp -rL ${DEPLOY_DIR_IMAGE}/u-boot-edison.bin ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/u-boot-edison.img ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/u-boot-envs ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-image-edison.ext3 ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-data.img ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-state.img ${DEPLOY_DIR_IMAGE}/resin-edison/
}

populate_append_edison() {
    # start using the kernel bundled with the meta-resin initramfs
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin ${DEST}/vmlinuz
    # copy example NetworkManager config file
    cp -r ${DEPLOY_DIR_IMAGE}/system-connections ${DEST}
    # copy the flag file for resinHUP
    cp ${DEPLOY_DIR_IMAGE}/${RESIN_IMAGE_FLAG_FILE} ${DEST}
}

# XXX
# This function is a replacement for that in poky/meta/classes/bootimg.bbclass
# in order to support resinhup on the Edison. Even though it's used for a
# variety of purposes in Poky, it only generates the boot partition on our
# version of the Edison HostOS. resinhup requires this partition to be
# >= 40MB in size. The problem with generating this partition with this
# size does not occur on other boards, as they have more accessible
# flashing methods permitting them to ship a IMAGE_FSTYPES of type
# "resinos-img" and not "hddimg".
build_fat_img() {
	FATSOURCEDIR=$1
	FATIMG=$2

	# mkdosfs will fail if ${FATIMG} exists. Since we are creating an
	# new image, it is safe to delete any previous image.
	if [ -e ${FATIMG} ]; then
		rm ${FATIMG}
	fi

	# value of RESIN_BOOT_SIZE from
	# meta-resin/meta-resin-common/classes/image_types_resin.bbclass
	BLOCKS=40960
	mkdosfs -F 32 -n ${BOOTIMG_VOLUME_ID} -S 512 -C ${FATIMG} \
		${BLOCKS}

	# Copy FATSOURCEDIR recursively into the image file directly
	mcopy -i ${FATIMG} -s ${FATSOURCEDIR}/* ::/
}

build_hddimg_prepend_edison() {
    install -d ${HDDDIR}

    # Copy files here to inject them in our boot partition
    init_config_json ${HDDDIR}
}

build_hddimg_append_edison() {
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-image-edison.hddimg ${DEPLOY_DIR_IMAGE}/resin-edison/
}

# The Edison ships with its own /etc/fstab, which differs from the one
# normally shipped with Poky. It requires a slightly different sed
# expression to switch the root partition to read-only.
read_only_rootfs_hook_append () {
    sed -i -e '/^[#[:space:]]*rootfs/{s/nodev/ro,nodev/;s/\([[:space:]]*[[:digit:]]\)\([[:space:]]*\)[[:digit:]]$/\1\20/}' ${IMAGE_ROOTFS}/etc/fstab
}
