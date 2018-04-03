# Copyright (C) 2015 Freescale Semiconductor
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KERNEL_SRC = "git://github.com/TechNexion/linux.git;protocol=https"
SRCBRANCH = "tn-imx_4.9.11_1.0.0_ga_test"
SRCREV = "015d775e416b47ab3a0db02fd6544f06c25568ce"

SRC_URI += " \
"

SRC_URI_append_imx7d-pico-sgtl += " \
	file://tn_imx_defconfig-Enable-Poxis-MQUEUE.patch \
"

SRC_URI_append_imx7d-pico-conexant += " \
	file://tn_imx_defconfig-Enable-Poxis-MQUEUE.patch \
"

do_copy_defconfig () {
	install -d ${B}
	# copy latest imx_v7_defconfig to use
	cp ${S}/arch/arm/configs/tn_imx_defconfig ${B}/.config
	cp ${S}/arch/arm/configs/tn_imx_defconfig ${B}/../defconfig
}

do_compile () {
	make tn_imx_defconfig
	make ${PARALLEL_MAKE} all
	make dtbs
}

COMPATIBLE_MACHINE = "(mx7)"
