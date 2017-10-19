FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI += " \
        file://remove-redundant-RPATH.patch \
"


