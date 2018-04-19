# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI_append_imx8mq-voicehat += " \
	file://0001-drivers-integrate-led-spha-and-tfa-drivers-for-8M.patch \
	file://0002-aloop-add-asound-loopback-driver.patch \
	file://0003-fsl-imx8mq-evk-hat-Add-HAT-soundcard-support.patch \
"

do_compile_imx8mq-voicehat () {
	make defconfig
	unset LDFLAGS
	make -j32 all
	make dtbs
	cp -v ${B}/arch/arm64/boot/dts/freescale/fsl-imx8mq-evk-hat.dtb ${B}/arch/arm64/boot/dts/freescale/fsl-imx8mq-evk.dtb
}

COMPATIBLE_MACHINE = "(mx8)"
