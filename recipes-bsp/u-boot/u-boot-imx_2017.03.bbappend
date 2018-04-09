# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

UBOOT_SRC = "git://github.com/TechNexion/u-boot-edm.git;protocol=https"
SRCBRANCH = "tn-imx_v2017.03_4.9.11_1.0.0_ga_test"
SRCREV = "${AUTOREV}"

LOCALVERSION = "tn-imx_v2017.03_4.9.11_1.0.0_ga_test"

SRC_URI_append_imx7d-pico-sgtl += " \
    file://pico-imx7-set-baseboard-to-pico-pi-on-uboot-environm.patch \
"

SRC_URI_append_imx7d-pico-conexant += " \
    file://pico-imx7-set-baseboard-to-pico-pi-on-uboot-environm.patch \
"

SRC_URI_append_imx7d-pico-voicehat += " \
    file://pico-imx7-set-baseboard-to-pico-pi-hat-on-uboot-environm.patch \
"

COMPATIBLE_MACHINE = "(imx7d-pico)"
