AVS_CONF="/etc/alexa_sdk/avs.conf"
SENSORY_FILE="/usr/lib/sensory-alexa/lib/libsnsr.a"

while [ ! -d "/etc/alexa_sdk/booted" ]
do
 echo ""
 echo "====================================================================== "
 echo " Welcome to Alexa SDK Image for NXP i.MX                               "
 echo " Let's setup your environemt...                                        "
 echo ""
 echo " ** Please enable the Network access by Ethernet/Wifi **               "
 echo ""
 echo " For using Wake Word Detection, please, accept the Sensory license...  "
 echo ""
 echo "====================================================================== "
 echo ""
 echo ""

 NETIF=$(route | grep '^default' | grep -o '[^ ]*$')
 timeout 30s udhcpc -i $NETIF
 if [ ! $? -eq 0 ]
 then
  echo "===================================================================== "
  echo ""
  echo " *** Fail to get a IP address ***"
  echo " Please enable the Network access by Ethernet/Wifi                    "
  echo ""
  echo "===================================================================== "
 exit 1
 fi
 
 /home/root/Alexa_SDK/Scripts/renewSensoryLicense.sh
 if [ -e $SENSORY_FILE ]
 then
  mkdir /etc/alexa_sdk/sensory
  sleep 2
 else
  echo ""
  echo ""
  echo " ==========================  WARNING  =============================== "
  echo ""
  echo " Currently there is no Sensory public available for ARM64             "
  echo " So Wake Word Detection is Disabled                                   "
  echo " You can always inlclude the Sensory models and lib manually          "
  echo " and rebuild Alexa SDK with Sensory                                   "
  echo ""
  echo " ==========================  WARNING  =============================== "
  sleep 4
 fi
 
 echo ""
 echo ""
 echo "====================================================================== "
 echo " Now we will setup your AVS Credentials                                "
 echo "====================================================================== "
 
 /home/root/Alexa_SDK/Scripts/setCredentials.sh
 if [ -e $AVS_CONF ]
 then
  mkdir /etc/alexa_sdk/booted
 fi

done

echo ""
echo ""
echo "======================================================================  "
echo " Done!!! You are now ready to start with Alexa SDK for NXP              "
echo ""
echo " To run the SampleApp:                                                  "
echo " "
echo "   cd ~/Alexa_SDK/avs-sdk-client/SampleApp/src/                         "
echo ""
if [ -e $SENSORY_FILE ]
then
 echo "   TZ=UTC ./SampleApp ../../Integration/AlexaClientSDKConfig.json \    "
 echo "   ../../Integration/inputs/SensoryModels/ DEBUG9                      "
else
 echo "   TZ=UTC ./SampleApp ../../Integration/AlexaClientSDKConfig.json \    "
 echo "   DEBUG9                                                              "
fi
echo ""
echo " NOTE: For make Alerts/Timers works properly on AVS, you need to        "
echo " sync your date to UTC. You can do it by running next script:           "
echo ""
echo "  /home/root/Alexa_SDK/Scripts/setUTCTime.sh                            "
echo ""
echo " Enjoy !!!                                                              "
echo "======================================================================= "
echo ""
echo ""

