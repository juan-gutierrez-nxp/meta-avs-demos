# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2018 TechNexion Ltd.
# Copyright 2017-2018 NXP
# Released under the MIT license (see COPYING.MIT for the terms)


FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI_append_pico-pi-8m-voicehat += " \
	file://0001-aloop-add-asound-loopback-driver-to-tn_imx8_defconfi.patch \
    file://0002-drivers-integrate-led-spha-and-tfa-drivers-for-8M.patch \
    file://0003-Add-pico-8m-voicehat.dts.patch \
    file://0004-tn_imx8_defconfig-add-SPHA-and-TFA-i.MX-drivers-to-d.patch \
    file://0001-dts-add-dtb-for-the-pico8m-with-voicehat.patch \
"


do_compile_pico-pi-8m-voicehat () {
    make tn_imx8_defconfig
    unset LDFLAGS
    make ${PARALLEL_MAKE} all
    make dtbs
}

COMPATIBLE_MACHINE = "(mx8)"

