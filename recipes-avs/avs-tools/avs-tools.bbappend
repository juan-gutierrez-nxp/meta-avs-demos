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

SRC_URI_append_imx7d-pico-voicehat += " \
    file://getDSPCSoftware.sh \
    file://startAwe.sh \
    file://alexa_sdk \
    file://setupAVS.sh \
"

SRC_URI_append_imx8mq-conexant += " \
    file://alexa_sdk \
    file://renewSensoryLicense.sh \
    file://setupAVS.sh \
"

SRC_URI_append_imx8mq-voicehat += " \
    file://getDSPCSoftware.sh \
    file://startAwe.sh \
    file://alexa_sdk \
    file://setupAVS.sh \
"
SRC_URI_append_imx-generic += " \
    file://alexa_sdk \
    file://renewSensoryLicense.sh \
    file://setupAVS.sh \
"

