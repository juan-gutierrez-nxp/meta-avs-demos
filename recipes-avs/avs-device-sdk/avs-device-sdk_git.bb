DESCRIPTION = "An SDK for commercial device makers to integrate Alexa directly \
               into connected products."

HOMEPAGE = "https://developer.amazon.com/avs/sdk"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=d92e60ee98664c54f68aa515a6169708"

SRC_URI = " \
	git://github.com/alexa/avs-device-sdk.git;branch=master;protocol=https \
    file://libsInstall.sh \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01._TTH_.mp3;name=melodic01tth \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01_short._TTH_.wav;name=melodic01short \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02._TTH_.mp3;name=melodic02tth \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02_short._TTH_.wav;name=melodic02short \
"
SRC_URI[melodic01tth.md5sum] = "0e2f42b7cb35c160a2783a8104d1cb2d"
SRC_URI[melodic01short.md5sum] = "fa0a26a6ec836974d853631e26036ed3"
SRC_URI[melodic02tth.md5sum] = "0c943e4d49907bb345277656c37e55db"
SRC_URI[melodic02short.md5sum] = "4638324a21d6264f0dc2c6d586371da8"

SRCREV = "8bf0160c5e56a3d5ebc1e1caeab14afc8658b0da"
#SRCREV = "${AUTOREV}"

INSANE_SKIP_${PN} = "dev-so"
TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}/git"
SB = "${WORKDIR}/build"

AVS_DIR ?= "/home/root/Alexa_SDK"

inherit cmake
EXTRA_OECMAKE = " \
	-DCMAKE_BUILD_TYPE=RELEASE \
	-DGSTREAMER_MEDIA_PLAYER=ON \
	-DCMAKE_INSTALL_PREFIX=${D}${AVS_DIR}/avs-sdk-client \
	-DPORTAUDIO=ON \
	-DPORTAUDIO_LIB_PATH=${STAGING_LIBDIR}/libportaudio.so \
	-DPORTAUDIO_INCLUDE_DIR=${STAGING_INCDIR} \
	\
"

TARGET_CXXFLAGS += " -D_GLIBCXX_USE_CXX11_ABI=0 "

RDEPENDS_${PN} += "bash"
DEPENDS = " \
	curl \
	sqlite3 \
    portaudio-v19 \
	packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
	gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-libav \
"

do_compile() {
    cd ${SB}
    make ${PARALLEL_MAKE} SampleApp
}

do_install() {
    install -d -m 0755 ${D}${AVS_DIR}
    install -d -m 0755 ${D}/sounds
    install -d -m 0755 ${D}/database
    install -d -m 0755 ${D}${AVS_DIR}/avs-sdk-client

    install  ${WORKDIR}/med_system_alerts_melodic_01._TTH_.mp3 ${D}/sounds/alarm_normal.mp3
    install  ${WORKDIR}/med_system_alerts_melodic_01_short._TTH_.wav ${D}/sounds/alarm_short.wav
    install  ${WORKDIR}/med_system_alerts_melodic_02._TTH_.mp3 ${D}/sounds/timer_normal.mp3
    install  ${WORKDIR}/med_system_alerts_melodic_02_short._TTH_.wav ${D}/sounds/timer_short.wav

	cd ${SB}
	find ./ -executable -type f -exec cp --parents -v {} ${D}/${AVS_DIR}/avs-sdk-client \;
    find ./ -name *.py -exec cp --parents -v {} ${D}/${AVS_DIR}/avs-sdk-client \;

    find ${D}/${AVS_DIR}/avs-sdk-client -name "*.py" -exec sed -e s#${SB}#${AVS_DIR}/avs-sdk-client#g -i {} \;
    mkdir ${D}/${AVS_DIR}/avs-sdk-client/Integration

    mkdir ${D}/${AVS_DIR}/libs
    cd ${D}/${AVS_DIR}/libs
    find ../avs-sdk-client -executable -type f -exec ${WORKDIR}/libsInstall.sh {} \;

    cp -r -L ${S} ${D}/${AVS_DIR}/avs-device-sdk
    cd ${D}/${AVS_DIR}/avs-device-sdk
    git repack -a -d
    rm .git/objects/info/alternates
}

FILES_${PN} = "${AVS_DIR} /sounds /database"
BBCLASSEXTEND = "native"

