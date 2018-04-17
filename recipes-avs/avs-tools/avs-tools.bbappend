FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_imx7d-pico-sgtl += " \
    file://alexa_sdk \
    file://renewSensoryLicense.sh \
    file://setupAVS.sh \
"
SRC_URI_append_imx7d-pico-conexant += " \
    file://alexa_sdk \
    file://renewSensoryLicense.sh \
    file://setupAVS.sh \
"
