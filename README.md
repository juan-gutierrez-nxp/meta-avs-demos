# meta-avs-demos for Alexa SDK for PICO PI 8M
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
    $ repo init -u ssh://git@bitbucket.sw.nxp.com/vs/meta-avs-demos.git -b internal -m imx-alexa-sdk-pico-8m.xml
    
#### Download the AVS BSP build environment:

    $ repo sync
---
### Step 2: Setup yocto for Alexa_SDK image with AVS-SETUP-DEMO script:

Run the avs-setup-demo script as follows to setup your environment for the
pico pi 8M board:

    $ MACHINE=pico-8m DISTRO=fsl-imx-xwayland source avs-setup-demo.sh -b <build_sdk>

Where <build_sdk> is the name you will give to your build folder.

After acepting the EULA the script will prompt if you want to enable:


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


Select **YES** if you already have the complementary meta-avs-demos-wifi layer.

#### Select MRM and not enable any other extra features

For instance of replicate the MRM Kit Image, only enable MRM and not select none of the additional extra-features
The other features has not been properly tested for the PicoPi

    Do you want to use AWELIB on buildtime on this image(Y/N)? **n**

    Do you want to include ESP (Echo Spatial Perception) support on this image(Y/N)? **n**

    Do you want to include QTDisplayCards on this image(Y/N)? **n**

    Do you want to include MRM on this image(Y/N)? **y**

#### Finish avs-image configuration


At the end you will see a text according with the configuration you select for
your image build.

Next is an example for a Preinstalled AVS_SDK with VoiceHat Sound Card support

    ============================================================
     AVS configuration is now ready at conf/local.conf

     - Sound Card = VoiceHat
     - Alexa SDK 1.9 pre-installed

     You are ready to bitbake your AVS demo image now:

         bitbake avs-image

     If you want to use QT5DisplayCards, use then:

         bitbake avs-image-qt5

    ============================================================

---

### Step 3: Build the AVS image

Go to your <build_sdk> directory and start the build of the avs-image

Use the following option to build the image

        $ cd  <yocto_dir>/<build_sdk>
        $ bitbake avs-image




The image with QT5 is useful if you want to add some GUI for example to render
DisplayCards.

---

### Step 4 : Deploying the built images to SD/MMC card to boot on target board.

After a build has succesfully completed, the created image resides at

    <build_sdk>/tmp/deploy/images/pico-8m/

In this directory, you will find **pico-8m-avs-<soundcard>-<version>.sdcard**
image or **pico-8m-avs-qt5-<soundcard>-<version>.sdcard**, depending on the
build you chose on Step3.

To Flash the .sdcard image into an SD Card follow the next steps:


- Extract and copy the .sdcard file to your SD Card
	
        $ cd <build_sdk>/tmp/deploy/images/pico-8m/
        $ cp -v pico-8m-avs-voicehat-1.9.sdcard.bz2 <workdir>
        $ cd <workdir>
        $ sudo bzip2 -d pico-8m-avs-voicehat-1.9.sdcard.bz2
        $ sudo dd if=pico-8m-avs-voicehat-1.9.sdcard of=/dev/sd<part> bs=1M && sync
        $ sync

- Properly eject the SD Card:

        $ sudo eject /dev/sd<part>


- Insert the flashed SD Card on the 8MM EVK and boot.

- Follow the instructions at startup to setup your AVS and run the SampleApp.

---

### NXP Documentation

For a more comprehensive understanding of Yocto, its features and setup; more
image build and deployment options and customization, please take a look at the
[i.MX_Yocto_Project_User's_Guide.pdf](https://goo.gl/E9RSxz) document from the
Linux documents bundle mentioned at the beginning of this document.

For a more detailed description of the Linux BSP, u-boot use and configuration,
please take a look at the [i.MX_Linux_User's_Guide.pdf](https://goo.gl/M8ujSY)
document from the Linux documents bundle mentioned at the beginning of this
document.

---



 2006  repo init -u ssh://git@bitbucket.sw.nxp.com/vs/meta-avs-demos.git -b internal -m imx-alexa-sdk-pico-8m.xml
 2007  repo sync
 2008  vim .repo/manifest.xml
 2009  repo sync
 2010  MACHINE=pico-8m DISTRO=fsl-imx-xwayland source avs-setup-demo.sh -b build_sdk_pico8m


Do you want to include WiFi support on this image(Y/N)? y

Do you want to use AWELIB on buildtime on this image(Y/N)? n

Do you want to include ESP (Echo Spatial Perception) support on this image(Y/N)? n

Do you want to include QTDisplayCards on this image(Y/N)? n

Do you want to include MRM on this image(Y/N)? y
