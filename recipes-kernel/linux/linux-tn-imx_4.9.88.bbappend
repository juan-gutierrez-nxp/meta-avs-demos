# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2018 TechNexion Ltd.
# Copyright 2017-2018 NXP
# Released under the MIT license (see COPYING.MIT for the terms)


FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI = "git://bitbucket.sw.nxp.com/scm/vs/kernel_technexion.git;branch=led_pico8m_dev;protocol=https"

SRCREV = "${AUTOREV}"
LOCALVERSION = "-led_pico8m_dev"

SRC_URI[md5sum] = "5a86d7ac674e34bcc2bb2bd5faae2cfe"
SRC_URI[sha256sum] = "d33be6cbd99714be420b18246c783927267193d53f55e430c85c4854f2464ec4"

SRC_URI_append_pico-pi-8m-voicehat += " \
    file://0001-tn_imx8_defconfig-set-SND_SOC_IMX_TFA98XX-as-module.patch \
"

do_compile_pico-pi-8m-voicehat () {
    make tn_imx8_defconfig
    unset LDFLAGS
    make ${PARALLEL_MAKE} all
    make dtbs
}

COMPATIBLE_MACHINE = "(mx8)"

