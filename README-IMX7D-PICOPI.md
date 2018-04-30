# meta-avs-demos for Alexa SDK for i.MX7D Pico Pi
---

Recipes to include Amazon's Alexa Voice Services in your applications.
---
### Step 1 : Get iMX Yocto AVS setup environment

Review the steps under Chapter 3 of the **i.MX_Yocto_Project_User'sGuide.pdf**
on the [L4.X LINUX_DOCS](https://goo.gl/Qcp4yA) to prepare your host machine.
Including at least the following essential Yocto packages

    $ sudo apt-get install gawk wget git-core diffstat unzip texinfo \
      gcc-multilib build-essential chrpath socat libsdl1.2-dev u-boot-tools

#### Install the i.MX NXP AVS repo

Create/Move to a directory where you want to install the AVS yocto build
enviroment.

Let's call this as <yocto_dir>


    $ cd <yocto_dir>
    $ repo init -u https://source.codeaurora.org/external/imxsupport/meta-avs-demos -b master -m imx-alexa-sdk-4.9.11.xml


#### Download the AVS BSP build environment:

    $ repo sync
---
### Step 2: Setup yocto for Alexa_SDK image with AVS-SETUP-DEMO script:

Run the avs-setup-demo script as follows to setup your environment for the
imx7d-pico board:


    $ MACHINE=imx7d-pico DISTRO=fsl-imx-x11 source avs-setup-demo.sh -b <build_sdk>

Where <build_sdk> is the name you will give to your build folder.

After acepting the EULA the script will prompt if you want to enable:
a
#### Sound Card selection

The following Sound Cards are supported on the build:

* SGTL (In-board Audio Codec for PicoPi)
* 2-Mic Synaptics/Conexant
* 2-Mic TechNexion Voice Hat (with DSPConcepts SW)

The script will prompt to select the soundcard you will be using:


     Which Sound Card are you going to use?

     Sigmatel ..............................  1
     Synaptics/Conexant ....................  2
     VoiceHat (for DSPConcepts SW) .........  3

    Type the number of your selection and press Enter...


#### Install Alexa SDK

Next option is to select if you want to pre-install the AVS SDK software on the
image.

    Do you want to build/include the AVS_SDK package on this image(Y/N)?

If you select **YES**, then your image will contain the AVS SDK ready to use
(after authentication). Note this AVS_SDK will not have WakeWord detection
support, but it can be added on runtime.

If your selection was **NO**, then you can always manually fetch and build the
AVS_SDK on runtime. All the packages dependencies will be already there, so
only fetching the AVS_SDK source code and building it is required.

#### Install WiFi support

Te WiFi support is optional and requires to get from NXP an additional
meta-picopi-wifi layer.
Contact NXP to get this layer to be able to support WiFi on your image

The image will prompt:

    Do you want to include WiFi support on this image(Y/N)?


Select **YES** if you already have the complementary meta-avs-demos-wifi layer


#### Finish avs-image configuration

At the end you will see a text according with the configuration you select for
your image build.

Next is an example for a Preinstalled AVS_SDK with Synaptics Sound Card support
and WiFi/BT not enabled for PicoPi board.

    ============================================================
     AVS configuration is now ready at conf/local.conf

     - Sound Card = Synaptics
     - Alexa SDK 1.7 pre-installed
     - Wifi supported

     You are ready to bitbake your AVS demo image now:

         bitbake avs-image

     If you want to use QT5DisplayCards, use then:

         bitbake avs-image-qt5

    ============================================================

---

### Step 3: Build the AVS image

Go to your <build_sdk> directory and start the build of the avs-image

There are 2 options

- Regular Build:

        $ cd  <yocto_dir>/<build_sdk>
        $ bitbake avs-image


- With QT5 support included:

        $ cd  <yocto_dir>/<build_sdk>
        $ bitbake avs-image-qt5


The image with QT5 is useful if you want to add some GUI for example to render
DisplayCards.

---

### Step 4 : Deploying the built images to SD/MMC card to boot on target board.

After a build has succesfully completed, the created image resides at

    <build_sdk>/tmp/deploy/images/imx7d-pico/

In this directory, you will find **imx7d-pico-avs-<soundcard>-<version>.sdcard**
image or **imx7d-pico-avs-qt5-<soundcard>-<version>.sdcard**, depending on the
build you chose on Step3.

To Flash the .sdcard image into the eMMC device of your PicoPi board follow the
next steps:

- Download the [bootbomb flasher](https://goo.gl/BAHS2H)
- Follow the instruction on **Section 4. Board Reflashing** of the
[Quick Start Guide for AVS kit](https://goo.gl/LHQG2c) to setup your board on
flashing mode.

- Copy the built SDCARD file

        $ sudo dd if=imx7d-pico-avs.sdcard of=/dev/sd<partition> bs=1M && sync
        $ sync

- Properly eject the pico-imx7d board:

        $ sudo eject /dev/sd<partition>

---

### NXP Documentation

Refer to the [Quick Start Quide for AVS SDK](https://goo.gl/BJnwn8) to fully
setup your PicoPi board with  Synaptics 2Mic and PicoPi i.mx7D

For a more comprehensive understanding of Yocto, its features and setup; more
image build and deployment options and customization, please take a look at the
[i.MX_Yocto_Project_User's_Guide.pdf](https://goo.gl/E9RSxz) document from the
Linux documents bundle mentioned at the beginning of this document.

For a more detailed description of the Linux BSP, u-boot use and configuration,
please take a look at the [i.MX_Linux_User's_Guide.pdf](https://goo.gl/M8ujSY)
document from the Linux documents bundle mentioned at the beginning of this
document.

---
