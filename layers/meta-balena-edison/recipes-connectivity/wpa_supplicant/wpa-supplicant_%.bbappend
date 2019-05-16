do_install_append_edison () {
    # The current edison BSP enables wpa_supplicant@wlan0.service
    # We use connman so we need to make sure wpa_supplicant@wlan0.service
    # service doesn't autostart, otherwise we get a conflict and the wlan0
    # interface is not usable. connman makes use only of the dbus version
    # of the systemd service (wpa_supplicant.service file).
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        rm ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
    fi
}
