SUMMARY = "Example of how to build an external Linux kernel module"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit module

INSANE_SKIP_${PN} = "already-stripped"
INSANE_SKIP_${PN} += "staticdev"


SRC_URI = "git://source.codeaurora.org/external/mas/tfa98xx;branch=master;protocol=https \
	   file://0001-Makefile-replace-KDIR-with-KERNEL_SRC.patch \
	   file://AlexaMRM_11022018.tar.xz \
"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEST_DIR = "/home/root"
FW_DIR = "/lib/firmware"

do_install() {
	install -d -m 0755 ${D}${DEST_DIR}
	install -d -m 0755 ${D}${FW_DIR}
        install -d -m 0755 ${D}${DEST_DIR}/tfa98xx
	cp ${S}/snd-soc-tfa98xx.ko ${D}${DEST_DIR}
	cp -r ${WORKDIR}/AlexaMRM_11022018/* ${D}${DEST_DIR}/tfa98xx/
        cp ${WORKDIR}/AlexaMRM_11022018/TFA9892N1A_stereo_32FS_Amazon_MRM.cnt ${D}${FW_DIR}
        cp ${WORKDIR}/AlexaMRM_11022018/TFA9892N1A_stereo_32FS_calibration.cnt ${D}${FW_DIR}
}

FILES_${PN} = "${DEST_DIR} ${FW_DIR} ${DEST_DIR}/tfa98xx"
BBCLASSEXTEND = "native"
