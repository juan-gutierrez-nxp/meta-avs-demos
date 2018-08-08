#!/bin/sh

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

sleep 1

SENSORY_FILE="/usr/lib/sensory-alexa/lib/libsnsr.a"

echo ""
echo "================================================================================"
echo "................................................................................"
echo ".................................000000........................................."
echo "..............................0000....0000......................................"
echo ".............................000.........00....................................."
echo "............................000...........00...................................."
echo "............................000...........00...................................."
echo ".............................000.........00....................................."
echo "..............................0000.....000......................................"
echo ".................................00..00........................................."
echo "................................................................................"
echo "................................................................................"
echo "....000000000.............0000000000.........000000000000000000000000000........"
echo "....00000000000...........00000000000......0000000000000000000000000000000......"
echo "....0000000000000.........000000000000....0000000000000...........000000000....."
echo "....00000000000000........00000000000000.00000000000000.............0000000....."
echo "....0000000000000000......00000000000000000000000000000..............0000000...."
echo "....00000000..00000000....00000000000000000000000000000.............00000000...."
echo "....00000000....00000000..00000000000000000000000000000............00000000....."
echo "....00000000.....0000000000000000000000000000000000000000000000000000000000....."
echo "....00000000.......00000000000000000000..00000000000000000000000000000000......."
echo "....00000000.........00000000000000000....0000000000000........................."
echo "....00000000...........00000000000000......000000000000........................."
echo "....00000000............000000000000.........0000000000........................."
echo "................................................................................"
echo "................................................................................"
echo "================================================================================"

echo ""
echo ""
echo "================================================================================="
echo " Welcome to NXP i.MX for Alexa SDK                                               "
echo ""

if [ ! -d "/etc/alexa_sdk/booted" ]
then
  echo " To setup your AVS Environment:                                                  "
  echo " - Go to Alexa_SDK directory and run the Setup AVS script:                       "
  echo -e "${GRAY}"
  echo "      cd ~/Alexa_SDK                                                             "
  echo "      ./setupAVS.sh                                                              "
   echo -e "${NC}"
  echo "  ** Please enable the Network access by Ethernet/Wifi **                        "
  echo ""
  echo "================================================================================="
else 
  echo " You are all set                                                                 "
  echo ""
  echo " To run the SampleApp:                                                  "
  echo -e "${GRAY}"
  echo "   cd ~/Alexa_SDK/                                                      "
  echo "   ./runAlexaSampleApp.sh"
  echo ""
  echo -e "${NC}"
fi
  echo "================================================================================="


