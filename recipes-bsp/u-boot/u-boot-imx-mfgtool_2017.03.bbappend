# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

UBOOT_SRC = "git://github.com/TechNexion/u-boot-edm.git;protocol=https"
SRCBRANCH = "tn-imx_v2015.04_4.1.15_1.0.0_ga"
SRCREV = "${AUTOREV}"

LOCALVERSION = "tn-imx_v2015.04_4.1.15_1.0.0_ga"

COMPATIBLE_MACHINE = "(mx7)"
