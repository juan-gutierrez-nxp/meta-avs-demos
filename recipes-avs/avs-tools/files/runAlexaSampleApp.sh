#!/bin/sh

if [ -e ~/Alexa_SDK/Scripts/runHookBeforSampleApp.sh ]
then
  ~/Alexa_SDK/Scripts/runHookBeforSampleApp.sh
fi

~/Alexa_SDK/Scripts/setUTCTime.sh

cd ~/Alexa_SDK/avs-sdk-client/SampleApp/src/

taskset -c 0 ./SampleApp ../../Integration/AlexaClientSDKConfig.json DEBUG9
