# meta-avs-demos for Alexa SDK for i.MX8M EVK
---

Recipes to include Amazon's Alexa Voice Services in your applications.
---
### Step 1 : Get iMX Yocto AVS setup environment

Review the steps under Chapter 3 of the **i.MX_Yocto_Project_User'sGuide.pdf**
on the [L4.X LINUX_DOCS](https://goo.gl/Qcp4yA) to prepare your host machine.
Including at least the following essential Yocto packages

    $ sudo apt-get install gawk wget git-core diffstat unzip texinfo \
      gcc-multilib build-essential chrpath socat libsdl1.2-dev u-boot-tools

#### Install the i.MX NXP **regular** BSP repo

Create/Move to a directory where you want to install the AVS yocto build
enviroment.

Let's call this as <yocto_dir>


Install the regular BSP (as usually does for a regular image).
For example for a 6ULL or 7DSabreSD 4.9.11 GA Release

    $ cd <yocto_dir>
    $ repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-morty -m imx-4.9.11-1.0.0_ga.xml


#### Download the regular BSP build environment:

    $ repo sync

#### Install the meta-avs-demo layer and creat a avs-setup-demo.sh symlink 

    $ cd <yocto_dir>/sources
    $ git clone https://source.codeaurora.org/external/imxsupport/meta-avs-demos --branch imx-alexa-sdk

    $ cd <yocto_dir>
    $ ln -s sources/meta-avs-demos/tools/avs-setup-demo-imx.sh avs-setup-demo.sh


---
### Step 2: Setup yocto for Alexa_SDK image with AVS-SETUP-DEMO script:

Run the avs-setup-demo script as follows to setup your environment for the
imx8mqevk board:


    $ cd <yocto_dir>
    $ MACHINE=<imx-machine> DISTRO=<fsl-imx-distro> source avs-setup-demo.sh -b <build_sdk>

Where:
  <build_sdk> is the name you will give to your build folder.
  <imx-machine> is the machine name like: imx6ullevk14x14, imx7dsabresd, imx6sxsabresd, etc.
  <fsl-imx-distro> is the distro like: fsl-imx-x11, fsl-imx-xwayland, etc.

After acepting the EULA the script will prompt if you want to enable:


#### Finish avs-image configuration

At the end you will see a text according with the configuration you select for
your image build.

Next is an example for Alexa SDK 1.7 

    ============================================================
     AVS configuration is now ready at conf/local.conf

     - Sound Card = On Board SoundCard
     - Alexa SDK 1.7 pre-installed

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

    <build_sdk>/tmp/deploy/images/<imx-machine>/

In this directory, you will find **<imx-machine>-avs-generic-<version>.sdcard**
image or **<imx-machine>-avs-qt5-generic-<version>.sdcard**, depending on the
build you chose on Step3.

To Flash the .sdcard image into an SD Card follow the regular process you do
on a regular BSP. For example for a 6ULLEVK14x14


- Extract and copy the .sdcard file to your SD Card
	
        $ cd <build_sdk>/tmp/deploy/images/imx6ull14x14evk/
        $ sudo dd if=imx6ull14x14evk-avs-generic-v1.7.sdcard of=/dev/sd<part> bs=1M && sync
        $ sync

- Properly eject the SD Card:

        $ sudo eject /dev/sd<part>


- Insert the flashed SD Card on the i.MX board and boot.

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
