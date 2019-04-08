#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

amixer cset numid=1 0
echo ""

if [ -d "/etc/alexa_sdk/calibrated" ]; then
  echo -e "${YELLOW}"
  echo "Your speakers are already calibrated"
  echo -e "${NC}"

  while true; do
   echo ""
   while read -r -t 0; do read -r; done
   read -p "do you want to calibrate it again ..." usrInput
   case $usrInput in
      [Y/y]*) rm -r /etc/alexa_sdk/calibrated; break;;
      [N/n]*) exit;;
      * ) echo "No valid option";;
   esac
  done
fi

if [ ! -d "/etc/alexa_sdk/calibrated" ]; then
 while true; do
  while read -r -t 0; do read -r; done
  echo ""
  echo -e "${YELLOW}"
  echo "==============================================================="
  echo ""
  echo "We MUST claibrate your speakers..."
  echo "Please connect BOTH of your speakers to the VoiceHAT and "
  echo "press Y when you are ready..."
  echo ""
  echo "==============================================================="
  echo -e "${NC}"
  read -p "Please answer Y when you are ready ..." usrInput

  case $usrInput in
      [Y]*) break;;
      * ) echo "No valid option";;
  esac
 done
 else 
  echo -e "${YELLOW}"
  echo "Your speakers are already calibrated"
  echo -e "${NC}"
  exit
fi


aplay -D hw:2,0 -r 48000 -t raw -c 2 -f S16_LE /dev/zero &
sleep 4
echo "## Reset MTP"
/home/root/climax -d /dev/i2c-1 -l /home/root/TFA9892N1A_stereo_32FS_calibration.cnt --resetMTP
sleep 5
echo "## Set Calibrate always first with calibration firmware"
/home/root/climax -d /dev/i2c-1 -l /home/root/TFA9892N1A_stereo_32FS_calibration.cnt --start --calibrate
sleep 5
echo "## Set Calibrate once"
/home/root/climax -d /dev/i2c-1 -l /home/root/TFA9892N1A_stereo_32FS_calibration.cnt --calibrate=once
sleep 7
echo "## Terminate aplay"
killall aplay
echo -n "MTPEX[0x34]="
cat /sys/kernel/debug/tfa98xx-34/MTPEX
MTPEX1=$(cat /sys/kernel/debug/tfa98xx-34/MTPEX)
echo -n "MTPEX[0x35]="
cat /sys/kernel/debug/tfa98xx-35/MTPEX
MTPEX2=$(cat /sys/kernel/debug/tfa98xx-35/MTPEX)
echo -n "OTC[0x34]="
cat /sys/kernel/debug/tfa98xx-34/OTC
OTC1=$(cat /sys/kernel/debug/tfa98xx-34/OTC)
echo -n "OTC[0x35]="
cat /sys/kernel/debug/tfa98xx-35/OTC
OTC2=$(cat /sys/kernel/debug/tfa98xx-35/OTC)

if [ "$MTPEX1" = "1" ] && [ "$MTPEX2" = "1" ] && [ "$OTC1" = "1" ] && [ "$OTC2" = "1" ]; then
   mkdir /etc/alexa_sdk/calibrated
   echo -e "${GREEN}"
   echo -e "Calibration succeed =D"
   echo -e "${NC}"
else
   echo -e "${RED}"
   echo -e "Calibration Failed :("
   echo -e "${NC}"
fi



