#!/bin/sh

AWBFILE=$(basename $(ls ~/AWE_CL/*.awb))
TSFFILE=$(basename $(ls ~/AWE_CL/*.tsf))

~/Alexa_SDK/Scripts/setUTCTime.sh
~/AWE_CL/AWE_command_line -binary:$AWBFILE -script:$TSFFILE
