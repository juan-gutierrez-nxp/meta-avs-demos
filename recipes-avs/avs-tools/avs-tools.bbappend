FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEST_SCRIPTS_DIR ?= "/home/root/Alexa_SDK/Scripts"

SRC_URI_append_pico-pi-8m-voicehat += " \
    file://getDSPCSoftware.sh \
    file://runHookBeforSampleApp.sh \
    file://compileAlexaWithAWB.sh \
"

do_install_append() {
    install -d -m 0755 ${D}${DEST_SCRIPTS_DIR}
    install ${S}/getDSPCSoftware.sh ${D}${DEST_SCRIPTS_DIR}
    install ${S}/runHookBeforSampleApp.sh ${D}${DEST_SCRIPTS_DIR}
    install ${S}/compileAlexaWithAWB.sh ${D}${DEST_SCRIPTS_DIR}
}

FILES_${PN} += "${DEST_SCRIPTS_DIR}"
