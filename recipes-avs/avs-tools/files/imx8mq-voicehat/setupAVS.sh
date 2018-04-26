AVS_CONF="/etc/alexa_sdk/avs.conf"

while [ ! -d "/etc/alexa_sdk/booted" ]
do
 echo ""
 echo "====================================================================== "
 echo " Welcome to Alexa SDK Image for NXP                                    "
 echo " Let's setup your environemt...                                        "
 echo ""
 echo " ** Please enable the Network access by Ethernet/Wifi **               "
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
 
 /home/root/Alexa_SDK/Scripts/getDSPCSoftware.sh

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
echo " Done!!! You are now ready to start with Alexa SDK for i.MX NXP         "
echo ""
echo " To run the SampleApp: "
echo " "
echo "   ~/Alexa_SDK/Scripts/startAwe.sh                                      "
echo ""
echo " And in a separate console (like by ssh), run:                          "
echo ""
echo "   cd ~/Alexa_SDK/avs-sdk-client/SampleApp/src/                         "
echo ""
echo "   TZ=UTC ./SampleApp ../../Integration/AlexaClientSDKConfig.json \     "
echo "   DEBUG9                                                               "
echo ""
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

