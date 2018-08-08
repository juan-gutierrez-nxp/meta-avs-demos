FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append_pico-pi-8m-voicehat += " pryonlite"

SRC_URI_append_pico-pi-8m-voicehat += " \
    file://0001-Integrate-AWELib-with-Alexa-SDK-1.7.patch \
    file://0003-Reducing-timeout-For-ThinkingToIdel.patch \
    file://0001-Add-loopback-to-feed-the-audio-of-external-app-to-AW.patch \
    file://0001-Convert-loopback-buffer-to-32-bits.patch \
    file://0001-Send-AWELib-Output-to-the-Playback-path.patch \
    file://0002-Divide-by-2-to-avoid-saturation.patch \
    file://0001-Mix-the-audio-buffers-in-a-more-proper-way.patch \
    file://0002-Workaround-for-the-cloud-based-false-wake-word-detec.patch \
    file://0001-Update-the-AWB-header-and-model-names.patch \
"
EXTRA_OECMAKE_pico-pi-8m-voicehat = " \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DAUDIOWEAVER_KEY_WORD_DETECTOR=ON \
    -DGSTREAMER_MEDIA_PLAYER=ON \
    -DCMAKE_INSTALL_PREFIX=${D}${AVS_DIR}/avs-sdk-client \
    -DPORTAUDIO=ON \
    -DPORTAUDIO_LIB_PATH=${STAGING_LIBDIR}/libportaudio.so \
    -DPORTAUDIO_INCLUDE_DIR=${STAGING_INCDIR} \
    -DAUDIOWEAVER_INCLUDE_DIR=${STAGING_INCDIR} \
    -DAUDIOWEAVER_LIB_PATH=${STAGING_LIBDIR} \
    \
"
do_compile_pico-pi-8m-voicehat() {
    make clean
}