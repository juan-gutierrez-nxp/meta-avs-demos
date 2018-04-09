SUMMARY = "Example of how to build an external Linux kernel module"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit module

INSANE_SKIP_${PN} = "already-stripped"
INSANE_SKIP_${PN} += "staticdev"

SRC_URI = " \
			file://linux_driver.zip \
			file://TFA9892N1A_stereo_32FS.cnt \
"

S = "${WORKDIR}/linux_driver"



DEST_DIR = "/home/root"
FW_DIR = "/lib/firmware"

do_install() {
	install -d -m 0755 ${D}${DEST_DIR}
	install -d -m 0755 ${D}${FW_DIR}
	cp ${S}/snd-soc-tfa98xx.ko ${D}${DEST_DIR}
	cp ${WORKDIR}/TFA9892N1A_stereo_32FS.cnt ${D}${FW_DIR}
}

FILES_${PN} = "${DEST_DIR} ${FW_DIR}"
BBCLASSEXTEND = "native"
