FILESEXTRAPATHS_append_edison := ":${THISDIR}/files"

SRC_URI_append_edison = " file://busybox-log.cfg"

# No syslog services
SYSTEMD_PACKAGES_edison = ""

# Remove alternative syslog files
ALTERNATIVE_${PN}-syslog_remove_edison = "syslog-conf"
