# As it can not overwrite the version in the layer meta-fsl-arm, we have to use
#   another file extension for new patch to the append in the meta-fsl-arm

# Append path for freescale layer to include alsa-state asound.conf
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# for i.MX7D
PACKAGE_ARCH_mx7 = "${MACHINE_ARCH}"

# for i.MX8M
PACKAGE_ARCH_mx8 = "${MACHINE_ARCH}"
