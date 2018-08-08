FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append_pico-pi-8m-voicehat += " pryonlite"

SRC_URI_append_pico-pi-8m-voicehat += " \
    file://0001-DSPC-Add-DSPC-AudioWeaver-support-within-Sample-App.patch \
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
