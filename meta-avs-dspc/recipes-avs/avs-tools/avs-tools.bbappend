FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEST_ETC_DIR ?= "/etc/alexa_sdk"
DEST_SDK_DIR ?= "/home/root/Alexa_SDK"
DEST_SCRIPTS_DIR ?= "/home/root/Alexa_SDK/Scripts"
S = "${WORKDIR}"

SRC_URI_append = " \
    file://no_sensory \
    file://dspc \
    file://getDSPCSoftware.sh \
    file://startAwe.sh \
"

do_install_append() {
    install -d -m 0755 ${D}${DEST_SCRIPTS_DIR}
    install -d -m 0755 ${D}${DEST_ETC_DIR}
    install ${S}/getDSPCSoftware.sh ${D}${DEST_SCRIPTS_DIR}
    install ${S}/startAwe.sh ${D}${DEST_SCRIPTS_DIR}
    install ${S}/no_sensory ${D}${DEST_ETC_DIR}
    install ${S}/dspc ${D}${DEST_ETC_DIR}
}

FILES_${PN} = "${DEST_ETC_DIR} ${DEST_SCRIPTS_DIR} ${DEST_SDK_DIR}"
BBCLASSEXTEND = "native"
