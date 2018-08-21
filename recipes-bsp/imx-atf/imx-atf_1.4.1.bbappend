# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_pico-pi-8m-voicehat += " \
    file://0001-Add-patch-uniform-ATF.patch \
    "

