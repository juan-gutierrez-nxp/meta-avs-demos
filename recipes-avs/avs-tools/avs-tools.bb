DESCRIPTION = "Custom scripts for start the AVS daemons and application and other utilities for imx7d-pico board"
HOMEPAGE = "http://developer.amazon.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
S = "${WORKDIR}"
BB_NUMBER_THREADS = "1"

DEST_ETC_DIR ?= "/etc/"
DEST_ETC_ALEXA_DIR ?= "/etc/alexa_sdk/"
DEST_HOME_DIR ?= "/home/root/"
DEST_SDK_DIR ?= "/home/root/Alexa_SDK/" 
DEST_SCRIPTS_DIR ?= "/home/root/Alexa_SDK/Scripts/"

INSANE_SKIP_${PN} += "installed-vs-shipped"
INSANE_SKIP_${PN} += "file-rdeps"

inherit systemd

SRC_URI = "git://bitbucket.sw.nxp.com/scm/vs/pico-pi-mrm-manually.git;branch=master;protocol=https"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git/"

do_install() {
    install -d -m 0755 ${D}${DEST_ETC_DIR}
    install -d -m 0755 ${D}${DEST_ETC_ALEXA_DIR}
    install -d -m 0755 ${D}${DEST_SDK_DIR}
    install -d -m 0755 ${D}${DEST_SCRIPTS_DIR}
    install -d -m 0755 ${D}${DEST_HOME_DIR}
    

    cp -r ${S}${DEST_ETC_ALEXA_DIR}/* ${D}${DEST_ETC_ALEXA_DIR}
    cp -r ${S}${DEST_SCRIPTS_DIR}/* ${D}${DEST_SCRIPTS_DIR}
    cp -r ${S}${DEST_ETC_DIR}/* ${D}${DEST_ETC_DIR}

    cp -r ${S}${DEST_HOME_DIR}/afe_process ${D}${DEST_HOME_DIR}
    cp -r ${S}${DEST_HOME_DIR}/led-daemon ${D}${DEST_HOME_DIR}

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0755  ${S}/${DEST_SCRIPTS_DIR}*.service ${D}/${systemd_unitdir}/system
    fi

    cd ${D}/${DEST_SDK_DIR}
    ln -s ${DEST_SCRIPTS_DIR}/setupAVS.sh setupAVS.sh
    ln -s ${DEST_SCRIPTS_DIR}/runAlexaSampleApp.sh runAlexaSampleApp.sh
}

FILES_${PN} = "${DEST_ETC_DIR} ${DEST_ETC_ALEXA_DIR}  ${DEST_SCRIPTS_DIR} ${DEST_SDK_DIR} ${DEST_HOME_DIR}"
BBCLASSEXTEND = "native"

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${PN}', '', d)}"
SYSTEMD_SERVICE_${PN} = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'startAVSImage.service', '', d)}"
FILES_${PN} += "${systemd_unitdir}/system/startAVSImage.service"
