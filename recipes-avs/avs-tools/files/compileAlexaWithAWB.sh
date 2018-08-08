#!/bin/sh

cpufreq-set -f 1000000

cp /home/root/Alexa_SDK/avs-sdk-client/Integration/AlexaClientSDKConfig.json /etc/alexa_sdk/

touch /home/root/Alexa_SDK/avs-device-sdk/SampleApp/src/PortAudioMicrophoneWrapper.cpp

cd /home/root/Alexa_SDK/avs-sdk-client

cmake /home/root/Alexa_SDK/avs-device-sdk \
-DCMAKE_BUILD_TYPE=RELEASE \
-DAUDIOWEAVER_KEY_WORD_DETECTOR=ON \
-DGSTREAMER_MEDIA_PLAYER=ON \
-DCMAKE_INSTALL_PREFIX=. \
-DPORTAUDIO=ON \
-DPORTAUDIO_LIB_PATH=/usr/lib/libportaudio.so \
-DPORTAUDIO_INCLUDE_DIR=/usr/include \
-DAUDIOWEAVER_INCLUDE_DIR=/usr/include \
-DAUDIOWEAVER_LIB_PATH=/usr/lib/ 

taskset -c 1,2,3 make SampleApp

mv /etc/alexa_sdk/AlexaClientSDKConfig.json /home/root/Alexa_SDK/avs-sdk-client/Integration/AlexaClientSDKConfig.json
