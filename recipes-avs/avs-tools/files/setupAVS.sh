AVS_CONF="/etc/alexa_sdk/avs.conf"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo ""
if [ -d "/etc/alexa_sdk/booted" ]; then
 while true; do
  while read -r -t 0; do read -r; done
  echo ""
  echo -e "${YELLOW}You already have an AVS configuration setup on place...${NC}"
  echo ""
  read -p "Do you want to start over with the AVS setup [Y/N]?" usrInput
  case $usrInput in
      [Yy]* )  rm -r /etc/alexa_sdk/booted; break;;
      [Nn]* )  break;;
      * ) echo "Please answer yes or no.";;
  esac
 done
fi


while [ ! -d "/etc/alexa_sdk/booted" ]
do
 echo ""
 echo "====================================================================== "
 echo " Welcome to Alexa SDK Image for NXP i.MX                               "
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
 
 echo ""
 echo ""
 echo "====================================================================== "
 echo " Now we will setup your AVS Credentials                                "
 echo "====================================================================== "
 
 /home/root/Alexa_SDK/Scripts/setCredentials.sh

 if [ -e /home/root/Alexa_SDK/Scripts/setSpotifyCredentials.sh ]; then
   /home/root/Alexa_SDK/Scripts/setSpotifyCredentials.sh
 fi

 if [ -e $AVS_CONF ]
 then
  mkdir /etc/alexa_sdk/booted
 fi

 if [ -e /home/root/Alexa_SDK/Scripts/getDSPCSoftware.sh ]; then
   /home/root/Alexa_SDK/Scripts/getDSPCSoftware.sh
 fi

done

echo ""
echo ""
echo "======================================================================  "
echo " Done!!! You are now ready to start with Alexa SDK for NXP i.MX         "
echo ""
echo " To run the SampleApp:                                                  "
echo -e "${GRAY}"
echo "   cd ~/Alexa_SDK/                                                      "
echo "   ./runAlexaSampleApp.sh"
echo ""
echo -e "${NC}"
echo " Enjoy !!!                                                              "
echo "======================================================================= "
echo -e "${NC}"
echo ""

