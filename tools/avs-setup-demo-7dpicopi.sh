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
PROGNAME="setup-environment"
exit_message ()
{
   echo "To return to this build environment later please run:"
   echo "    source setup-environment <build_dir>"

}

usage()
{
    echo -e "\nUsage: source fsl-setup-release.sh
    Optional parameters: [-b build-dir] [-e back-end] [-h]"
echo "
    * [-b build-dir]: Build directory, if unspecified script uses 'build' as output directory
    * [-e back-end]: Options are 'fb', 'dfb', 'x11, 'wayland'
    * [-h]: help
"
}


clean_up()
{

    unset CWD BUILD_DIR BACKEND FSLDISTRO
    unset fsl_setup_help fsl_setup_error fsl_setup_flag
    unset usage clean_up
    unset ARM_DIR META_FSL_BSP_RELEASE
    exit_message clean_up
}

# get command line options
OLD_OPTIND=$OPTIND
unset FSLDISTRO

while getopts "k:r:t:b:e:gh" fsl_setup_flag
do
    case $fsl_setup_flag in
        b) BUILD_DIR="$OPTARG";
           echo -e "\n Build directory is " $BUILD_DIR
           ;;
        e)
            # Determine what distro needs to be used.
            BACKEND="$OPTARG"
            if [ "$BACKEND" = "fb" ]; then
                if [ -z "$DISTRO" ]; then
                    FSLDISTRO='fsl-imx-fb'
                    echo -e "\n Using FB backend with FB DIST_FEATURES to override poky X11 DIST FEATURES"
                elif [ ! "$DISTRO" = "fsl-imx-fb" ]; then
                    echo -e "\n DISTRO specified conflicts with -e. Please use just one or the other."
                    fsl_setup_error='true'
                fi

            elif [ "$BACKEND" = "dfb" ]; then
                if [ -z "$DISTRO" ]; then
                    FSLDISTRO='fsl-imx-dfb'
                    echo -e "\n Using DirectFB backend with DirectFB DIST_FEATURES to override poky X11 DIST FEATURES"
                elif [ ! "$DISTRO" = "fsl-imx-dfb" ]; then
                    echo -e "\n DISTRO specified conflicts with -e. Please use just one or the other."
                    fsl_setup_error='true'
                fi

            elif [ "$BACKEND" = "wayland" ]; then
                if [ -z "$DISTRO" ]; then
                    FSLDISTRO='fsl-imx-wayland'
                    echo -e "\n Using Wayland backend."
                elif [ ! "$DISTRO" = "fsl-imx-wayland" ]; then
                    echo -e "\n DISTRO specified conflicts with -e. Please use just one or the other."
                    fsl_setup_error='true'
                fi

            elif [ "$BACKEND" = "x11" ]; then
                if [ -z "$DISTRO" ]; then
                    FSLDISTRO='fsl-imx-x11'
                    echo -e  "\n Using X11 backend with poky DIST_FEATURES"
                elif [ ! "$DISTRO" = "fsl-imx-x11" ]; then
                    echo -e "\n DISTRO specified conflicts with -e. Please use just one or the other."
                    fsl_setup_error='true'
                fi

            else
                echo -e "\n Invalid backend specified with -e.  Use fb, dfb, wayland, or x11"
                fsl_setup_error='true'
            fi
           ;;
        h) fsl_setup_help='true';
           ;;
        ?) fsl_setup_error='true';
           ;;
    esac
done


if [ -z "$DISTRO" ]; then
    if [ -z "$FSLDISTRO" ]; then
        FSLDISTRO='fsl-imx-x11'
    fi
else
    FSLDISTRO="$DISTRO"
fi

OPTIND=$OLD_OPTIND

# check the "-h" and other not supported options
if test $fsl_setup_error || test $fsl_setup_help; then
    usage && clean_up && return 1
fi

if [ -z "$BUILD_DIR" ]; then
    BUILD_DIR='build'
fi

if [ -z "$MACHINE" ]; then
    echo setting to default machine
    MACHINE='imx6qsabresd'
fi

# copy new EULA into community so setup uses latest i.MX EULA
cp sources/meta-fsl-bsp-release/imx/EULA.txt sources/meta-freescale/EULA
cp sources/meta-avs-demos/tools/image_types_picopi.bbclass sources/meta-fsl-bsp-release/imx/meta-bsp/classes/
cp sources/meta-avs-demos/tools/imx-picopi-base.inc sources/meta-freescale/conf/machine/include/imx-picopi-base.inc


# Delete upstream machine and bbclass files that we have modified
machine_roots="sources/meta-fsl-bsp-release/imx/meta-bsp/conf/machine"
for machine_root in $machine_roots; do
   if [ -d $machine_root ]; then
      machines="$machines $machine_root/*"
      machine_includes="$machine_includes $machine_root/include/*"
   fi
done
for machine in $machines; do
   if [ -f $machine ]; then
      upstream_machine=sources/meta-freescale/conf/machine/`basename $machine`
      if [ -f $upstream_machine ]; then
         rm $upstream_machine
      fi
   fi
done
for machine_include in $machine_includes; do
   if [ -f $machine_include ]; then
      upstream_machine_include=sources/meta-freescale/conf/machine/include/`basename $machine_include`
      if [ -f $upstream_machine_include ]; then
         rm $upstream_machine_include
      fi
   fi
done
bbclass_roots="sources/meta-fsl-bsp-release/imx/meta-bsp/classes"
for bbclass_root in $bbclass_roots; do
   if [ -d $bbclass_root ]; then
      bbclasses="$bbclasses $bbclass_root/*"
   fi
done
for bbclass in $bbclasses; do
   if [ -f $bbclass ]; then
      upstream_bbclass=sources/meta-freescale/classes/`basename $bbclass`
      if [ -f $upstream_bbclass ]; then
         rm $upstream_bbclass
      fi
   fi
done

# Set up the basic yocto environment
if [ -z "$DISTRO" ]; then
   DISTRO=$FSLDISTRO MACHINE=$MACHINE . ./$PROGNAME $BUILD_DIR
else
   MACHINE=$MACHINE . ./$PROGNAME $BUILD_DIR
fi

# Point to the current directory since the last command changed the directory to $BUILD_DIR
BUILD_DIR=.

if [ ! -e $BUILD_DIR/conf/local.conf ]; then
    echo -e "\n ERROR - No build directory is set yet. Run the 'setup-environment' script before running this script to create " $BUILD_DIR
    echo -e "\n"
    return 1
fi

# On the first script run, backup the local.conf file
# Consecutive runs, it restores the backup and changes are appended on this one.
if [ ! -e $BUILD_DIR/conf/local.conf.org ]; then
    cp $BUILD_DIR/conf/local.conf $BUILD_DIR/conf/local.conf.org
else
    cp $BUILD_DIR/conf/local.conf.org $BUILD_DIR/conf/local.conf
fi


if [ ! -e $BUILD_DIR/conf/bblayers.conf.org ]; then
    cp $BUILD_DIR/conf/bblayers.conf $BUILD_DIR/conf/bblayers.conf.org
else
    cp $BUILD_DIR/conf/bblayers.conf.org $BUILD_DIR/conf/bblayers.conf
fi


META_FSL_BSP_RELEASE="${CWD}/sources/meta-fsl-bsp-release/imx/meta-bsp"
echo "##Freescale Yocto Project Release layer" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-fsl-bsp-release/imx/meta-bsp \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-fsl-bsp-release/imx/meta-sdk \"" >> $BUILD_DIR/conf/bblayers.conf

echo "BBLAYERS += \" \${BSPDIR}/sources/meta-browser \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-openembedded/meta-gnome \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-openembedded/meta-networking \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-openembedded/meta-python \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-openembedded/meta-filesystems \"" >> $BUILD_DIR/conf/bblayers.conf

echo "BBLAYERS += \" \${BSPDIR}/sources/meta-qt5 \"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \" \${BSPDIR}/sources/meta-avs-demos \"" >> $BUILD_DIR/conf/bblayers.conf

echo BSPDIR=$BSPDIR
echo BUILD_DIR=$BUILD_DIR

# Support integrating community meta-freescale instead of meta-fsl-arm
if [ -d ../sources/meta-freescale ]; then
    echo meta-freescale directory found
    # Change settings according to environment
    sed -e "s,meta-fsl-arm\s,meta-freescale ,g" -i conf/bblayers.conf
    sed -e "s,\$.BSPDIR./sources/meta-fsl-arm-extra\s,,g" -i conf/bblayers.conf
fi

sed -e "s,PACKAGECONFIG_append_pn-qemu-native = \" sdl\",,g" -i $BUILD_DIR/conf/local.conf
sed -e "s,PACKAGECONFIG_append_pn-nativesdk-qemu = \" sdl\",,g" -i $BUILD_DIR/conf/local.conf

echo ""

SOUNDCARD="SGTL"
while true; do
    echo " Which Sound Card are you going to use? "
    echo ""
    echo " Sigmatel ..............................  1"
    echo " Synaptics/Conexant ....................  2"
    echo " VoiceHat (for DSPConcepts SW) .........  3"
    echo ""
    read -p "Type the number of your selection and press Enter... " usrInput
    case $usrInput in
        [1]* ) SOUNDCARD="SGTL" break;;
        [2]* ) SOUNDCARD="CONEXANT"; break;;
        [3]* ) SOUNDCARD="VOICEHAT"; break;;
           * ) ;;
    esac
done


BUILD_ALEXA_SDK=0
ALEXA_VERSION=`cat $BSPDIR/sources/meta-avs-demos/version.txt`
while true; do
    echo ""
    read -p "Do you want to build/include the Alexa SDK package on this image(Y/N)? " usrInput
    case $usrInput in
        [Yy]* ) BUILD_ALEXA_SDK=1; break;;
        [Nn]* ) BUILD_ALEXA_SDK=0; break;;
            * ) echo "Please answer yes or no.";;
    esac
done



BUILD_WIFI=0
while true; do
    echo ""
    read -p "Do you want to include WiFi support on this image(Y/N)? " usrInput
    case $usrInput in
        [Yy]* ) BUILD_WIFI=1; break;;
        [Nn]* ) BUILD_WIFI=0; break;;
            * ) echo "Please answer yes or no.";;
    esac
done


if [ $BUILD_WIFI == 1 ]; then
   if [ ! -d ${BSPDIR}/sources/meta-picopi-wifi ]; then
       BUILD_WIFI=0
       RED='\033[0;31m'
       NC='\033[0m' # No Color
       echo -e "${RED}"
       echo "============================================================= "
       echo " WARNING: meta-picopi-wifi layer needs to be included on  "
       echo " the sources directory to be able to include WiFi Support     "
       echo " on this image. Please Contact NXP to get the meta layer.     "
       echo "============================================================= "
       echo -e "${NC}"
    else
       echo "BBLAYERS += \" \${BSPDIR}/sources/meta-picopi-wifi \"" >> $BUILD_DIR/conf/bblayers.conf
    fi
fi


if [ $BUILD_ALEXA_SDK == 1 ]; then
    echo "" >> $BUILD_DIR/conf/local.conf
    echo "#Enable Building of AVS_SDK and install AVS Scripts" >> $BUILD_DIR/conf/local.conf
    echo "IMAGE_INSTALL_append = \" avs-device-sdk\"" >> $BUILD_DIR/conf/local.conf
    echo "IMAGE_INSTALL_append = \" avs-tools\"" >> $BUILD_DIR/conf/local.conf
    echo "" >> $BUILD_DIR/conf/local.conf
    echo "#Alexa Version" >> $BUILD_DIR/conf/local.conf
    echo "SDKVERSION = \"$ALEXA_VERSION\"" >> $BUILD_DIR/conf/local.conf
    echo "" >> $BUILD_DIR/conf/local.conf
fi

if [ $SOUNDCARD == "CONEXANT" ]; then
    echo "" >> $BUILD_DIR/conf/local.conf
    echo "#Enable the Conexant Sound Card" >> $BUILD_DIR/conf/local.conf
    echo "MACHINEOVERRIDES =. \"imx7d-pico-conexant:\"" >> $BUILD_DIR/conf/local.conf
    echo "SOUNDCARD = \"synaptics\"" >> $BUILD_DIR/conf/local.conf
    echo "" >> $BUILD_DIR/conf/local.conf
fi

if [ $SOUNDCARD == "SGTL" ]; then
    echo "" >> $BUILD_DIR/conf/local.conf
    echo "#Enable the SGTL Sound Card" >> $BUILD_DIR/conf/local.conf
    echo "MACHINEOVERRIDES =. \"imx7d-pico-sgtl:\"" >> $BUILD_DIR/conf/local.conf
    echo "SOUNDCARD = \"sgtl\"" >> $BUILD_DIR/conf/local.conf
    echo "" >> $BUILD_DIR/conf/local.conf
fi

if [ $SOUNDCARD == "VOICEHAT" ]; then
    echo "" >> $BUILD_DIR/conf/local.conf
    echo "#Enable the TechNexion 2Mics Voice Hat Sound Card for DSPConcepts" >> $BUILD_DIR/conf/local.conf
    echo "MACHINEOVERRIDES =. \"imx7d-pico-voicehat:\"" >> $BUILD_DIR/conf/local.conf
    echo "KERNEL_DEVICETREE = \"imx7d-pico_pi-hat.dtb\"" >> $BUILD_DIR/conf/local.conf
    echo "SOUNDCARD = \"voicehat\"" >> $BUILD_DIR/conf/local.conf
    echo "" >> $BUILD_DIR/conf/local.conf
fi

if [ $BUILD_WIFI == 1 ]; then
    echo "" >> $BUILD_DIR/conf/local.conf
    echo "#Enable the BCMD WiFi" >> $BUILD_DIR/conf/local.conf
    echo "IMAGE_INSTALL_append = \" firmware-bcmdhd\"" >> $BUILD_DIR/conf/local.conf
    echo "" >> $BUILD_DIR/conf/local.conf
fi


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
echo "\"meta-avs-demos/recipes-kernel/linux/linux-imx_4.9.51.bbappend\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf


echo "#Rootfs size (Full eMMC - uboot/kernel partitions) = 3.5GB - 16MB" >> $BUILD_DIR/conf/local.conf
echo "IMAGE_ROOTFS_SIZE = \"3333152\"" >> $BUILD_DIR/conf/local.conf
echo "IMAGE_OVERHEAD_FACTOR = \"1.0\"" >> $BUILD_DIR/conf/local.conf
echo "" >> $BUILD_DIR/conf/local.conf


echo ""
echo "============================================================ "
echo " AVS configuration is now ready at conf/local.conf           "
echo "                                                             "
if [ $SOUNDCARD == "CONEXANT" ]; then
echo " - Sound Card = Synaptics                                    "
fi
if [ $SOUNDCARD == "SGTL" ]; then
echo " - Sound Card = Sigmatel                                     "
fi
if [ $SOUNDCARD == "VOICEHAT" ]; then
echo " - Sound Card = 2Mics Voice Hat (for DSPC)                   "
fi
if [ $BUILD_ALEXA_SDK == 1 ]; then
echo " - Alexa SDK $ALEXA_VERSION pre-installed                    "
else
echo " - Alexa SDK is NOT installed                                "
echo "   (All Alexa SDK pkg dependencies are included in the image."
echo "   You can install it on runtime)                            "
fi
if [ $BUILD_WIFI == 1 ]; then
echo " - Wifi supported                                            "
fi
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
