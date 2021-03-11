NOHDD_edison = "0"

inherit image-live

# TODO
# This was already fixed in poky but fix was not backported to daisy
# To be removed in the future
do_bootimg[depends] += "virtual/kernel:do_deploy"
do_bootimg[depends] += "networkmanager:do_deploy"
do_bootimg[depends] += "balena-image:do_rootfs"

# We need to ensure docker-disk has deployed resin-data.img by the time we need it
do_image_complete[depends] += "docker-disk:do_deploy"

# Do not use legacy nor EFI BIOS
PCBIOS_edison = "0"

# Specify rootfs image type
IMAGE_FSTYPES_append_edison = " hddimg"

# We currently use ext4 rootfs partitions
# Also depend on the rootfs type declared by meta-resin
IMAGE_TYPEDEP_hddimg = "ext4 ${BALENA_ROOT_FSTYPE}"

# force the rootfs creation task depend on the existence of mkfs-hostapp-native in the sysroot
do_rootfs[depends] += "mkfs-hostapp-native:do_populate_sysroot"

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

BALENA_BOOT_PARTITION_FILES_append = " \
    u-boot-edison.bin: \
    u-boot-envs/edison-blankcdc.bin: \
    ${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin:/vmlinuz \
"

define_labels() {
    #Missing labels
    e2label ${IMGDEPLOYDIR}/balena-image-edison.${BALENA_ROOT_FSTYPE} ${BALENA_ROOTA_FS_LABEL}
    e2label ${DEPLOY_DIR_IMAGE}/resin-data.img ${BALENA_DATA_FS_LABEL}
}

deploy_bundle() {
    # Create an empty ext4 filesystem for the second rootfs partition (resin-rootB) big enough to hold the resin image rootfs
    BALENA_ROOTB_BLOCKS=${IMAGE_ROOTFS_SIZE}
    rm -rf ${DEPLOY_DIR_IMAGE}/resin-rootB.img
    dd if=/dev/zero of=${DEPLOY_DIR_IMAGE}/resin-rootB.img count=${BALENA_ROOTB_BLOCKS} bs=1024
    mkfs.ext4 -F -L "${BALENA_ROOTB_FS_LABEL}" ${DEPLOY_DIR_IMAGE}/resin-rootB.img

    # Create an empty ext4 filesystem for our config partition
    BALENA_STATE_BLOCKS=${BALENA_STATE_SIZE}
    rm -rf ${DEPLOY_DIR_IMAGE}/resin-state.img
    dd if=/dev/zero of=${DEPLOY_DIR_IMAGE}/resin-state.img count=${BALENA_STATE_BLOCKS} bs=1024
    mkfs.ext4 -F -L "${BALENA_STATE_FS_LABEL}" ${DEPLOY_DIR_IMAGE}/resin-state.img

    mkdir -p ${DEPLOY_DIR_IMAGE}/resin-edison
    cp -rL ${DEPLOY_DIR_IMAGE}/u-boot-edison.bin ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/u-boot-edison.img ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/u-boot-envs ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${IMGDEPLOYDIR}/balena-image-edison.${BALENA_ROOT_FSTYPE} ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-data.img ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-rootB.img ${DEPLOY_DIR_IMAGE}/resin-edison/
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-state.img ${DEPLOY_DIR_IMAGE}/resin-edison/
}

populate_live_append_edison() {
    # copy os-release to the boot partition
    install -m 0644 ${DEPLOY_DIR_IMAGE}/os-release ${HDDDIR}
    # copy the generated <machine-name>.json to the boot partition, renamed as device-type.json
    install -m 0644 ../${MACHINE}.json ${HDDDIR}/device-type.json
    # copy image-version-info to the boot partition
    install -m 0644 ${IMGDEPLOYDIR}/../resin-boot/image-version-info ${HDDDIR}/
    # copy the bootfiles balenaos.fingerprint to the boot partition
    install -m 0644 ${IMGDEPLOYDIR}/../resin-boot/balenaos.fingerprint ${HDDDIR}/
    # copy the splash directory over to the boot partition
    install -d ${HDDDIR}/splash
    install -m 0755 ${IMGDEPLOYDIR}/../resin-boot/splash/* ${HDDDIR}/splash/
    # start using the kernel bundled with the meta-resin initramfs
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin ${HDDDIR}/vmlinuz
    # copy example NetworkManager config file
    cp -r ${DEPLOY_DIR_IMAGE}/system-connections ${HDDDIR}
    # copy the flag file for resinHUP
    cp ${DEPLOY_DIR_IMAGE}/${BALENA_IMAGE_FLAG_FILE} ${HDDDIR}
}

# XXX
# This function is a replacement for that in poky/meta/classes/bootimg.bbclass
# in order to support resinhup on the Edison. Even though it's used for a
# variety of purposes in Poky, it only generates the boot partition on our
# version of the Edison HostOS. resinhup requires this partition to be
# >= 40MB in size. The problem with generating this partition with this
# size does not occur on other boards, as they have more accessible
# flashing methods permitting them to ship a IMAGE_FSTYPES of type
# "balenaos-img" and not "hddimg".
build_fat_img() {
	FATSOURCEDIR=$1
	FATIMG=$2

	# we do not need the rootfs image and initrd in our boot partition
	rm -rf ${FATSOURCEDIR}/rootfs.img ${FATSOURCEDIR}/initrd

	# mkdosfs will fail if ${FATIMG} exists. Since we are creating an
	# new image, it is safe to delete any previous image.
	if [ -e ${FATIMG} ]; then
		rm ${FATIMG}
	fi

	# value of BALENA_BOOT_SIZE from
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
    # we need to create the hddimg symlink now when we do the copy ( Yocto Pyro creates this symlink after this build_hddimg function is called)
    chmod 0644 ${IMGDEPLOYDIR}/${IMAGE_NAME}.hddimg
    rm -rf ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.hddimg
    ln -s ${IMGDEPLOYDIR}/${IMAGE_NAME}.hddimg ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.hddimg
    cp -rL ${IMGDEPLOYDIR}/balena-image-edison.hddimg ${DEPLOY_DIR_IMAGE}/resin-edison/
}

# The Edison ships with its own /etc/fstab, which differs from the one
# normally shipped with Poky. It requires a slightly different sed
# expression to switch the root partition to read-only.
read_only_rootfs_hook_append () {
    sed -i -e '/^[#[:space:]]*rootfs/{s/nodev/ro,nodev/;s/\([[:space:]]*[[:digit:]]\)\([[:space:]]*\)[[:digit:]]$/\1\20/}' ${IMAGE_ROOTFS}/etc/fstab
}
