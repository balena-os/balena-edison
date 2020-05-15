inherit kernel-resin

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0002-NFLX-2019-001-SACK-Panic.patch \
            file://0004-NFLX-2019-001-SACK-Slowness.patch \
            file://0005-NFLX-2019-001-Resour-Consump-Low-MSS.patch \
            file://0006-NFLX-2019-001-Resour-Consump-Low-MSS.patch \
            "

# enable USB hub kernel module as requested by customer
RESIN_CONFIGS_append = " smsc95xx"
RESIN_CONFIGS[smsc95xx] = "CONFIG_USB_NET_SMSC95XX=m"

# add mmc support as module so it does not conflict with the WiFi (WiFi breaks when sdhci is compiled in the kernel as opposed to being a module)
RESIN_CONFIGS_append = " mmc_module"
RESIN_CONFIGS[mmc_module] = "\
    CONFIG_MMC=m \
    CONFIG_MMC_BLOCK=m \
    CONFIG_MMC_SDHCI=m \
    CONFIG_MMC_SDHCI_PCI=m \
    "

# compile i2c support as module as a workaround to get i2c-6 working (https://svenschwermer.de/2017/10/14/intel-edison-i2c6-with-vanilla-linux.html)
RESIN_CONFIGS_append = " i2c_module"
RESIN_CONFIGS[i2c_module] = "\
    CONFIG_I2C_DESIGNWARE_CORE=m \
    CONFIG_I2C_DESIGNWARE_PCI=m \
    "

# enabling only host mode because at this point having CONFIG_USB_DWC3_DUAL_ROLE won't get host mode working correctly (lsusb will complain with: unable to initialize libusb: -99)
RESIN_CONFIGS_append = " dwc3_host_mode"
RESIN_CONFIGS[dwc3_host_mode] = "CONFIG_USB_DWC3_HOST=y"

# enable ftdi_sio as a module (as requested by customer)
RESIN_CONFIGS_append = " ftdi_sio"
RESIN_CONFIGS[ftdi_sio] = "CONFIG_USB_SERIAL_FTDI_SIO=m"

# let's allow for /dev/i2c-* devices to be created (this enables userspace to use the I2C buses)
RESIN_CONFIGS_append = " i2c_chardev"
RESIN_CONFIGS[i2c_chardev] = "CONFIG_I2C_CHARDEV=y"

# compile uvcvideo.ko (as requested by customer)
RESIN_CONFIGS_append = " uvcvideo"
RESIN_CONFIGS[uvcvideo] = "CONFIG_USB_VIDEO_CLASS=m"
RESIN_CONFIGS_DEPS[uvcvideo] = "\
    CONFIG_MEDIA_SUPPORT=m \
    CONFIG_MEDIA_USB_SUPPORT=y \
    CONFIG_MEDIA_CAMERA_SUPPORT=y \
    "

# compile cdc-acm.ko (as requested by customer)
RESIN_CONFIGS_append = " cdc-acm"
RESIN_CONFIGS[cdc-acm] = "CONFIG_USB_ACM=m"

# add support for fuse (as requested by customer)
RESIN_CONFIGS_append = " fuse"
RESIN_CONFIGS[fuse] = "CONFIG_FUSE_FS=m"
