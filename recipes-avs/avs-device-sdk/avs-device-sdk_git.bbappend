FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_imx7d-pico-voicehat += " \
	file://0001-Add-Dummy-Key-Word-Detector.patch \
	file://0001-SampleApp-Sample-code-patch-to-add-support-for-QT5Di.patch \
	file://0002-Enabling-WW-detection-in-cloud.patch \
"
EXTRA_OECMAKE_imx7d-pico-voicehat = " \
	-DCMAKE_BUILD_TYPE=RELEASE \
	-DDUMMY_KEY_WORD_DETECTOR=ON \
	-DGSTREAMER_MEDIA_PLAYER=ON \
	-DCMAKE_INSTALL_PREFIX=${D}${AVS_DIR}/avs-sdk-client \
	-DPORTAUDIO=ON \
	-DPORTAUDIO_LIB_PATH=${STAGING_LIBDIR}/libportaudio.so \
	-DPORTAUDIO_INCLUDE_DIR=${STAGING_INCDIR} \
	\
"

SRC_URI_append_imx8mq-voicehat += " \
	file://0001-Add-Dummy-Key-Word-Detector.patch \
	file://0001-SampleApp-Sample-code-patch-to-add-support-for-QT5Di.patch \
"
EXTRA_OECMAKE_imx8mq-voicehat = " \
	-DCMAKE_BUILD_TYPE=RELEASE \
	-DDUMMY_KEY_WORD_DETECTOR=ON \
	-DGSTREAMER_MEDIA_PLAYER=ON \
	-DCMAKE_INSTALL_PREFIX=${D}${AVS_DIR}/avs-sdk-client \
	-DPORTAUDIO=ON \
	-DPORTAUDIO_LIB_PATH=${STAGING_LIBDIR}/libportaudio.so \
	-DPORTAUDIO_INCLUDE_DIR=${STAGING_INCDIR} \
	\
"


#PATCHTOOL = "git"
