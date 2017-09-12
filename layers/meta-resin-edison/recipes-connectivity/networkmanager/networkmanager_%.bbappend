FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append = " file://resin-wired"

do_install_append() {
    # don't enable random mac address for scanning on the Intel Edison
    cat >> ${D}${sysconfdir}/NetworkManager/NetworkManager.conf <<EOF

[device]
wifi.scan-rand-mac-address=no
EOF
}

do_deploy_append() {
    install -d "${DEPLOYDIR}/system-connections/"
    install -m 0600 "${WORKDIR}/resin-wired" "${DEPLOYDIR}/system-connections/"
}
