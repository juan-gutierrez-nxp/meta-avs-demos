DESCRIPTION = "An SDK for commercial device makers to integrate Alexa directly \
               into connected products."

HOMEPAGE = "https://developer.amazon.com/avs/sdk"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=d92e60ee98664c54f68aa515a6169708"

SRC_URI = " \
	git://github.com/alexa/avs-device-sdk.git;branch=master \
	file://AlexaClientSDKConfig.json \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01._TTH_.mp3;name=melodic01tth \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_01_short._TTH_.wav;name=melodic01short \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02._TTH_.mp3;name=melodic02tth \
	https://images-na.ssl-images-amazon.com/images/G/01/mobile-apps/dex/alexa/alexa-voice-service/docs/audio/states/med_system_alerts_melodic_02_short._TTH_.wav;name=melodic02short \
"
SRC_URI[melodic01tth.md5sum] = "0e2f42b7cb35c160a2783a8104d1cb2d"
SRC_URI[melodic01short.md5sum] = "fa0a26a6ec836974d853631e26036ed3"
SRC_URI[melodic02tth.md5sum] = "0c943e4d49907bb345277656c37e55db"
SRC_URI[melodic02short.md5sum] = "4638324a21d6264f0dc2c6d586371da8"

SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git" 
SB = "${WORKDIR}/build/"

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

do_install() {
    install -d -m 0755 ${D}${AVS_DIR}
    install -d -m 0755 ${D}/sounds
    install -d -m 0755 ${D}/database
    install -d -m 0755 ${D}${AVS_DIR}/avs-device-sdk
    install -d -m 0755 ${D}${AVS_DIR}/avs-sdk-client
    cp -r ${SB}/* ${D}/${AVS_DIR}/avs-sdk-client/
    cp  ${WORKDIR}/med_system_alerts_melodic_01._TTH_.mp3 ${D}/sounds/alarm_normal.mp3
    cp  ${WORKDIR}/med_system_alerts_melodic_01_short._TTH_.wav ${D}/sounds/alarm_short.wav
    cp  ${WORKDIR}/med_system_alerts_melodic_02._TTH_.mp3 ${D}/sounds/timer_normal.mp3
    cp  ${WORKDIR}/med_system_alerts_melodic_02_short._TTH_.wav ${D}/sounds/timer_short.wav

	cd ${D}/${AVS_DIR}/
	git clone git://github.com/alexa/avs-device-sdk.git avs-device-sdk

	cd ${D}/${AVS_DIR}/avs-sdk-client/

   find -type f ! \( -name "*.so" -o -name "*.o" -o -name "*internal" -o -name "*cache" -o -name "SampleApp" -o -name "*.py" \) -exec rm {} \;
   find -type f \( -name "*internal" -o -name "*cache" -o -name "*.py" \) -exec sed -e s#${TMPDIR}/work/cortexa7hf-neon-poky-linux-gnueabi/avs-device-sdk/git-r0/git#/home/root/Alexa_SDK/avs-device-sdk#g -i {} \;
   find -type f \( -name "*internal" -o -name "*cache" -o -name "*.py" \) -exec sed -e s#${TMPDIR}/sysroots/imx7d-pico##g -i {} \;
   find -type f \( -name "*internal" -o -name "*cache" -o -name "*.py" \) -exec sed -e s#${TMPDIR}/work/cortexa7hf-neon-poky-linux-gnueabi/avs-device-sdk/git-r0/build#/home/root/Alexa_SDK/avs-sdk-client#g -i {} \;
   find -type f \( -name "*internal" -o -name "*cache" -o -name "*.py" \) -exec sed -e s#${TMPDIR}/work/cortexa7hf-neon-poky-linux-gnueabi/avs-device-sdk/git-r0/image##g -i {} \;
   find -type f \( -name "*internal" -o -name "*cache" -o -name "*.py" \) -exec sed -e s#/${TMPDIR}/sysroots/x86_64-linux/usr/bin/arm-poky-linux-gnueabi#/usr/bin#g -i {} \;
   find -type f \( -name "*internal" -o -name "*cache" -o -name "*.py" \) -exec sed -e s#/${TMPDIR}/sysroots/x86_64-linux/usr/bin#/usr/bin#g -i {} \;

	chrpath -r "${AVS_DIR}/avs-sdk-client/ApplicationUtilities/DefaultClient/src:${AVS_DIR}/avs-sdk-client/AuthDelegate/src:${AVS_DIR}/avs-sdk-client/MediaPlayer/src:${AVS_DIR}/avs-sdk-client/KWD/Sensory/src:${AVS_DIR}/avs-sdk-client/ACL/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/AIP/src:${AVS_DIR}/avs-sdk-client/ADSL/src:${AVS_DIR}/avs-sdk-client/AFML/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/Alerts/src:${AVS_DIR}/avs-sdk-client/CertifiedSender/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/PlaybackController/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/SpeakerManager/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/SpeechSynthesizer/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/Settings/src:${AVS_DIR}/avs-sdk-client/Storage/SQLiteStorage/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/TemplateRuntime/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/AudioPlayer/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/System/src:${AVS_DIR}/avs-sdk-client/ContextManager/src:${AVS_DIR}/avs-sdk-client/PlaylistParser/src:${AVS_DIR}/avs-sdk-client/KWD/src:${AVS_DIR}/avs-sdk-client/AVSCommon"  ${D}/${AVS_DIR}/avs-sdk-client/SampleApp/src/SampleApp

    chrpath -r "${AVS_DIR}/avs-sdk-client/ACL/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/AIP/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/Alerts/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/SpeechSynthesizer/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/AudioPlayer/src:${AVS_DIR}/avs-sdk-client/CapabilityAgents/System/src:${AVS_DIR}/avs-sdk-client/ContextManager/src:${AVS_DIR}/avs-sdk-client/ADSL/src:${AVS_DIR}/avs-sdk-client/AFML/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/ApplicationUtilities/DefaultClient/src/libDefaultClient.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/KWD/src/libKWD.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/PlaylistParser/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/MediaPlayer/src/libMediaPlayer.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/AuthDelegate/src/libAuthDelegate.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/ContextManager/src/libContextManager.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/ACL/src:${AVS_DIR}/avs-sdk-client/AuthDelegate/src:${AVS_DIR}/avs-sdk-client/AVSCommon" ${D}/${AVS_DIR}/avs-sdk-client/Integration/src/libIntegration.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/Storage/SQLiteStorage/src/libSQLiteStorage.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/ACL/src/libACL.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/ADSL/src/libADSL.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/PlaylistParser/src/libPlaylistParser.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/Storage/SQLiteStorage/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/Settings/src/libSettings.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/Storage/SQLiteStorage/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/TemplateRuntime/src/libTemplateRuntime.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/Storage/SQLiteStorage/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/SpeakerManager/src/libSpeakerManager.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/AudioPlayer/src/libAudioPlayer.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/System/src/libAVSSystem.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/ContextManager/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/PlaybackController/src/libPlaybackController.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/SpeechSynthesizer/src/libSpeechSynthesizer.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/Alerts/src/libAlerts.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/ADSL/src:${AVS_DIR}/avs-sdk-client/AFML/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CapabilityAgents/AIP/src/libAIP.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/Storage/SQLiteStorage/src:${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/CertifiedSender/src/libCertifiedSender.so
    chrpath -r "${AVS_DIR}/avs-sdk-client/AVSCommon:" ${D}/${AVS_DIR}/avs-sdk-client/AFML/src/libAFML.so
}

FILES_${PN} = "${AVS_DIR} /sounds /database"
BBCLASSEXTEND = "native"

