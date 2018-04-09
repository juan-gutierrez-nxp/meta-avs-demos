FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRCREV = "${AUTOREV}"

SRC_URI += " \
	file://0001-Add-Dummy-Key-Word-Detector.patch \
	file://0001-SampleApp-Sample-code-patch-to-add-support-for-QT5Di.patch \
"
EXTRA_OECMAKE = " \
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
