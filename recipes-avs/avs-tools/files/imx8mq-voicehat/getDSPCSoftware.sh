#!/bin/bash
date -s "$(curl http://s3.amazonaws.com -v 2>&1 | grep "Date: " | awk '{ print $3 " " $5 " " $4 " " $7 " " $6 " GMT"}')"
cd /home/root/

if [ -d "/home/root/AWE_CL" ]
then
    rm -r /home/root/AWE_CL
fi

if [ -d "/home/root/sensory_files" ]
then
    rm -r /home/root/sensory_files
fi

if [ -d "/home/root/audioweaver" ]
then
    rm -r /home/root/audioweaver
fi


git clone https://bitbucket.sw.nxp.com/scm/vs/dspc-nxp-imx8m-2micVoiceUI.git
cd dspc-nxp-imx8m-2micVoiceUI
tar -xvf AWE_CL_8M.tar.bz2 -C /home/root/

  while :; do
    fold -s -w `tput cols`  LICENSE.md | more
    echo ""
    echo "Press Enter to continue ..."
    while read -r -t 0; do read -r; done
    echo ""
    echo ""
    read -p "Do you accept the DSPC license you just read? (y/n)" usrInput
    case $usrInput in
        [Yy]* )  break;;
        [Nn]* )  ;;
        * ) echo "Please answer yes or no.";;
    esac
  done
