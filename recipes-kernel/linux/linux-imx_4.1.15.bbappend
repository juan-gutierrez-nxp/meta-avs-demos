# Copyright (C) 2015 Freescale Semiconductor
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

KERNEL_SRC = "git://github.com/TechNexion/linux.git;protocol=https"
SRCBRANCH = "tn-imx_4.1.15_2.0.0_ga"
SRCREV = "d2e98efca60e21ad1b835f0960b5d86009356d69"

SRC_URI += " \
		file://0001-Set-the-right-clk-provider-of-SYS_MCLK-for-SGTL-code.patch \
		file://0001-Enable-SND_USB_AUDIO.patch \
		file://0001-tn_imx_defconfig-Enable-Poxis-MQUEUE.patch \
"
do_copy_defconfig () {
	# copy latest imx_v7_defconfig to use
	cp ${S}/arch/arm/configs/tn_imx_defconfig ${B}/.config
	cp ${S}/arch/arm/configs/tn_imx_defconfig ${B}/../defconfig
}

do_compile () {
	make tn_imx_defconfig
	make all
	make dtbs
}

COMPATIBLE_MACHINE = "(mx7)"
