# The current edison BSP enables wpa_supplicant@wlan0.service
# We use connman so we need to mask this interface specific service,
# otherwise we get a conflict and the wlan0 interface is not usable.
# connman makes use only of the dbus version of the systemd service
# (wpa_supplicant.service file).

DEPENDS_append_edison = " ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-systemctl-native', '', d)}"
pkg_postinst_${PN}_append_edison () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        if [ -n "$D" ]; then
            OPTS="--root=$D"
        fi
        systemctl $OPTS mask wpa_supplicant@wlan0.service
    fi
}
