FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append = " file://77-mm-tty-device-blacklist.rules"

do_install_append() {
    install -D -m 0644 ${WORKDIR}/77-mm-tty-device-blacklist.rules ${D}/lib/udev/rules.d/
}
