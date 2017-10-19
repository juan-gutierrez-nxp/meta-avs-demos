FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Enable pango lib
PACKAGECONFIG_append = " pango "

# Remove gio-unix-2.0 as it does not seem to exist anywhere
PACKAGECONFIG_remove = "gio-unix-2.0"
# Overwrite the unrecognised option which is set in gstreamer1.0-plugins-base.inc under poky layer
PACKAGECONFIG[gio-unix-2.0] = ""

SRC_URI_append = " file://0001-gstplaybin-remove-default-deinterlace-flag.patch \
                   file://0002-Linux_MX6QP_ARD-IMXCameraApp-When-Enable.patch \
                   file://0003-Remove-dependence-on-imx-plugin-git.patch \
                   file://0004-basetextoverlay-make-memory-copy-when-video-buffer-s.patch \
                   file://0005-gstplaysink-don-t-set-async-of-custom-text-sink-to-f.patch \
                   file://0006-taglist-not-send-to-down-stream-if-all-the-frame-cor.patch \
                   file://0007-handle-audio-video-decoder-error.patch \
                   file://0008-gstaudiobasesink-print-warning-istead-of-return-ERRO.patch \
                   file://0009-Disable-orc-optimization-for-lib-video-in-plugins-ba.patch \
                   file://0010-dmabuf-Make-the-allocator-sub-classable.patch \
                   file://0011-dmabuf-allocator-Add-missing-padding-in-the-class.patch \
                   file://0012-dmabuf-Add-free-function.patch \
                   file://0013-ion-DMA-Buf-allocator-based-on-ion.patch \
                   file://0014-ion-DMA-Buf-allocator-based-on-ion2.patch \
                   file://0015-streamsynchronizer-every-stream-need-keep-their-own-.patch \
                   file://0016-subparse-fix-critical-log-print-out-when.patch \
"

PACKAGE_ARCH_mxs = "${MACHINE_SOCARCH}"
PACKAGE_ARCH_mx5 = "${MACHINE_SOCARCH}"
PACKAGE_ARCH_mx6 = "${MACHINE_SOCARCH}"
