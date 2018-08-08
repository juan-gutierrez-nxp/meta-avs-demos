#!/bin/sh 

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color


echo ""
if [ -d "/etc/alexa_sdk/dspc_installed" ]; then
 while true; do
  while read -r -t 0; do read -r; done
  echo ""
  echo -e "${YELLOW}You already have DSPC SW already installed...${NC}"
  echo ""
  read -p "Do you want to re-compile and re-installed DSPC again [Y/N]?" usrInput
  case $usrInput in
      [Yy]* )  rm -r /etc/alexa_sdk/dspc_installed; break;;
      [Nn]* )  break;;
      * ) echo "Please answer yes or no.";;
  esac
 done
fi


while [ ! -d "/etc/alexa_sdk/dspc_installed" ]
do

 echo "======================================================================"
 echo -e "${YELLOW}"
 echo " On this particular image the Alexa_SDK needs DSP Concepts Software   "
 echo " to propely work. Now the DSPC binaries will be downloaded.           "
 echo " Please read and accept the license to be able to continue the setup. "
 echo -e "${NC}"
 echo "======================================================================"
 echo ""
 sleep 2

 if [ -d "/home/root/AWELib" ]
 then
    rm -r /home/root/AWELib
 fi

 cd /home/root/
 git clone https://bitbucket.sw.nxp.com/scm/vs/awelib.git -b imx8m_2mic AWELib

 cd /home/root/AWELib

 echo ""
 echo ""
 fold -s -w `tput cols` LICENSE.txt | more
 echo ""
 accepted=0

 while true; do

    while read -r -t 0; do read -r; done

    echo ""
    read -p "Do you accept this DSPC license agreement?[Y/N]: " yno
    case $yno in
        [yY]* ) accepted=1; break;;
        [nN]* ) accepted=0; break;;
        * ) echo 'Please answer yes or no.';;
    esac
 done


 if [ $accepted == 1 ]
 then
    cp -v /home/root/AWELib/*.h /usr/include/
    cp -v /home/root/AWELib/include/* /usr/include/
    cp -v /home/root/AWELib/lib/* /usr/lib/
    ln -s /usr/lib/AWELib.so /usr/lib/libAWELib.so   

    echo ""
    echo ""
    echo -e "${YELLOW}"
    echo " The Alexa_SDK will be compiled now to incluide DSPC Software. "
    echo " This might take some minutes(if this is the first time)...    "
    echo -e "${NC}"
    echo ""
    echo ""
    sleep 2
    /home/root/Alexa_SDK/Scripts/compileAlexaWithAWB.sh
    ln -s /home/root/amazon_files/D.en-US.alexa.bin /home/root/Alexa_SDK/avs-sdk-client/SampleApp/src/D.en-US.alexa.bin
    mkdir /etc/alexa_sdk/dspc_installed
 else
    echo "====================================================================== "
    echo -e "${RED}"
    echo " By not accpeting the DSPC License you won't be able to run Alexa SDK  "
    echo " properly on this setup. Please run again the setupAVS.sh ans accept   "
    echo " the license to be able to proceed                                     "
    echo -e "${NC}"
    echo "====================================================================== "
    rm -r /home/root/AWELib
 fi
done

