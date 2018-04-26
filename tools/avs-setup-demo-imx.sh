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

source ${BSPDIR}/fsl-setup-release.sh

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
A
LEXA_VERSION
echo "" >> $BUILD_DIR/conf/local.conf
echo "#Set a Generic i.MX Configuration " >> $BUILD_DIR/conf/local.conf
echo "MACHINEOVERRIDES =. \"imx-generic:\"" >> $BUILD_DIR/conf/local.conf
echo "SOUNDCARD = \"generic\"" >> $BUILD_DIR/conf/local.conf
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
echo "\"meta-avs-demos/recipes-kernel/linux\\" >> $BUILD_DIR/conf/local.conf
echo "|meta-avs-demos/recipes-bsp/u-boot\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf


echo ""
echo "============================================================ "
echo " AVS configuration is now ready at conf/local.conf           "
echo "                                                             "
echo " - Sound Card = On Board SoundCard                           "
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
