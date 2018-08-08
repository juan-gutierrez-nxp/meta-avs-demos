#!/bin/sh
#
# FSL Build Enviroment Setup Script
#
# Copyright (C) 2011-2015 Freescale Semiconductor
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

CWD=`pwd`
BSPDIR=$CWD

# Patch recipes

source ${BSPDIR}/edm-setup-release.sh

echo "BBLAYERS += \" \${BSPDIR}/sources/meta-avs-demos \"" >> $BUILD_DIR/conf/bblayers.conf

sed -e "s,PACKAGECONFIG_append_pn-qemu-native = \" sdl\",,g" -i $BUILD_DIR/conf/local.conf
sed -e "s,PACKAGECONFIG_append_pn-nativesdk-qemu = \" sdl\",,g" -i $BUILD_DIR/conf/local.conf

ALEXA_VERSION=`cat $BSPDIR/sources/meta-avs-demos/version.txt`

echo "" >> $BUILD_DIR/conf/local.conf
echo "#Enable Building of AVS_SDK and install AVS Scripts" >> $BUILD_DIR/conf/local.conf
echo "IMAGE_INSTALL_append = \" avs-device-sdk\"" >> $BUILD_DIR/conf/local.conf
echo "IMAGE_INSTALL_append = \" avs-tools\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf
echo "#Alexa Version" >> $BUILD_DIR/conf/local.conf
echo "SDKVERSION = \"$ALEXA_VERSION\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf

echo "" >> $BUILD_DIR/conf/local.conf
echo "#Set a Generic i.MX Configuration " >> $BUILD_DIR/conf/local.conf
echo "MACHINEOVERRIDES =. \"pico-pi-8m-voicehat:\"" >> $BUILD_DIR/conf/local.conf
echo "KERNEL_DEVICETREE = \"freescale/pico-8m-voicehat.dtb\"" >> $BUILD_DIR/conf/local.conf
echo "SOUNDCARD = \"voicehat\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf

echo "LICENSE_FLAGS_WHITELIST ?= \"commercial_gst-fluendo-mp3 \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_gst-openmax \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_gst-plugins-ugly \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_gst-ffmpeg \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_gstreamer1.0-libav \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_lame \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_libav \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_libpostproc \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_mplayer2 \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_x264 \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_libmad \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_mpeg2dec \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial_qmmp \\" >> $BUILD_DIR/conf/local.conf
echo "                             oracle_java \\" >> $BUILD_DIR/conf/local.conf
echo "                             commercial \\" >> $BUILD_DIR/conf/local.conf
echo "                             \"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf

echo "PREFERRED_PROVIDER_jpeg = \"libjpeg-turbo\"" >> $BUILD_DIR/conf/local.conf
echo "PREFERRED_PROVIDER_jpeg-native = \"libjpeg-turbo-native\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf


echo "BBMASK +=\\" >> $BUILD_DIR/conf/local.conf
echo "\"meta-avs-demos/recipes-kernel/linux/linux-imx_4.9.11.bbappend\\" >> $BUILD_DIR/conf/local.conf
echo "|meta-avs-demos/recipes-kernel/linux/linux-imx_4.9.51.bbappend\\" >> $BUILD_DIR/conf/local.conf
echo "|meta-avs-demos/recipes-kernel/linux/linux-imx_4.9.88.bbappend\\" >> $BUILD_DIR/conf/local.conf
echo "|meta-avs-demos/recipes-kernel/linux/linux-wand-imx_4.9.51.bbappend\\" >> $BUILD_DIR/conf/local.conf
echo "|meta-avs-demos/recipes-kernel/linux/linux-imx_4.9.51.bbappend\\" >> $BUILD_DIR/conf/local.conf
echo "|meta-avs-demos/recipes-bsp/u-boot/u-boot-wand_2017.03.bbappend\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf

BUILD_AMAZONLITE=1
if [ $BUILD_AMAZONLITE == 1 ]; then
   if [ ! -d ${BSPDIR}/sources/meta-avs-amazonlite-wakeword ]; then
       BUILD_AMAZONLITE=0
       RED='\033[0;31m'
       NC='\033[0m' # No Color
       echo -e "${RED}"
       echo "============================================================= "
       echo " WARNING: meta-avs-amazonlite-wakeword layer needs to be      "
       echo " included on the sources directory to be able to get the      "
       echo " Amazon Lite WakeWord on this image.                          "
       echo " Please Contact NXP to get the meta layer.                    "
       echo "============================================================= "
       echo -e "${NC}"
    else
       echo "BBLAYERS += \" \${BSPDIR}/sources/meta-avs-amazonlite-wakeword \"" >> $BUILD_DIR/conf/bblayers.conf
       echo ""
       echo "BBMASK +=\\" >> $BUILD_DIR/conf/local.conf
       echo "\"meta-avs-amazonlite-wakeword/recipes-pryonlite/avs-device-sdk\"" >> $BUILD_DIR/conf/local.conf
       echo "BBMASK +=\\" >> $BUILD_DIR/conf/local.conf
       echo "\"meta-avs-amazonlite-wakeword/recipes-pryonlite/images\"" >> $BUILD_DIR/conf/local.conf
       echo "" >> $BUILD_DIR/conf/local.conf
    fi
fi

if [ -d ${BSPDIR}/sources/meta-avs-extra-features ]; then
    source ${BSPDIR}/sources/meta-avs-extra-features/tools/avs-setup-extra-features.sh
fi

echo "" >> $BUILD_DIR/conf/local.conf
echo "#WakeWord" >> $BUILD_DIR/conf/local.conf
echo "WAKEWORD = \"-dspc\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf


echo ""
echo "============================================================ "
echo " AVS configuration is now ready at conf/local.conf           "
echo "                                                             "
echo " - Sound Card = 2Mics Voice Hat (for DSPC)                   "
echo " - Alexa SDK $ALEXA_VERSION pre-installed                    "
echo ""
echo " You are ready to bitbake your AVS demo image now:           "
echo "                                                             "
echo "     bitbake avs-image                                       "
echo ""
echo " If you want to use QT5DisplayCards, use then:               "
echo ""
echo "     bitbake avs-image-qt5"
echo "                                                             "
echo "============================================================ "
echo ""

cd  $BUILD_DIR
clean_up
unset FSLDISTRO
