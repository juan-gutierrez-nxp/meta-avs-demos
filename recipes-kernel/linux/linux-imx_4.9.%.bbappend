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

SRC_URI_append_imx7d-pico-voicehat += " \
	file://0001-Set-PLL-Audio-to-be-used-as-MCLK-for-SAI-modules.patch \
	file://0002-MP34DT01-MEM-Mic.patch \
	file://0003-8mic-array-board-support.patch \
	file://0004-SPH0645-MEMs-Mic.patch \
	file://0005-CS4244-initial-Support.patch \
	file://0006-TCA9532-Level-shifter.patch \
	file://0007-Allow-SAI-to-be-bound-to-more-than-one-cards.patch \
	file://0008-Trigger-SAI-before-any-change-to-CODEC.-Some-codecs-.patch \
	file://0009-Reset-and-reconfigure-codec.-This-is-needed-because-.patch \
	file://0010-Generate-SPH0645-as-loadable-module.patch \
	file://0011-Remove-pr_info-in-mp34dt01.patch \
	file://0012-tfa98xx-Add-TFA98XX-support.patch \
	file://0013-SPH-change-to-2-channels.patch \
	file://0014-dts-HAT-2-Mic-support.patch \
	file://0015-SND_LOOP-Enable-ALSA-Sosund-Loopback-device.patch \
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
