# Change Log/Release Notes

## [imx-alexa-sdk_1.7] - 2018-04-30

* Port to Alexa SDK 1.7
* New Authentication method introduced on version 1.7
  For more details check [Run and authorize](https://github.com/alexa/avs-device-sdk/wiki/Linux-Reference-Guide#run-and-authorize)
* Due to the new Auth method, the Script only will ask for Client ID.
  Notice the Client ID is now from the "Other devices and Platform" Section
  and NOT from the "Web" Section as it used to be (on your Alexa Developer
  Home site)
* Remove Firefox and x11vnc as no longer required with new Auth method.

* Add IMX Generic Support. To be able to build for any NXP BSP supported i.MX
  board.
* Split README.md on 3 README files per board: i.MX8MEVK, i.MX7DPico and
  Generic i.MX.


## Known Issues

* The AWE Client for 8M is temporally allocated on an internal NXP repo.
  So image will not work for Public access. Also additional HW is required
  like an interposer for connecting the VoiceHat.

* There is also no public support for 8M for Sensory, so right now the WakeWord
  for Synaptics image is disabled but Alexa SampleApp can run with keyboard commands.
 


## [imx-alexa-sdk_1.6] - 2018-04-25

### General changes

* Fix GCC compiler issues on runtime for i.mx7D Pico. The GCC included on the
  generated image was not built with all the required flags for the i.MX7D
  architecture
* Fix SRCREV on the bbappend to SDK 1.6
* Reorganization of the avs-tools scripts per sound-card directory. So each
  machine-soundcard variant will have its own copy of setupAVS.sh, startImage,
  etc. And any other specific script that only applies to a particular card
  like getDSPConcepts.sh it will be only allocated in its specific directory.
  These allow a cleaner script, eliminating macros for differentiation.
* Remove meta-avs-dspc sublayer. Due to the reorg of the avs-tools, a similar
  approach can be taken for other recipes like the avs-device-sdk and avs-image
  and allow the meta-avs-dspc to be removed.
* remove unnecessary installation of curlbuild.h needed for 8M proper build
* Add i.MX8M EVK support. Two variants are supported: Voicehat and Synaptics
  soundcards.


## Known Issues

* The AWE Client for 8M is temporally allocated on an internal bitbucket repo.
  So image needs to be run and setup on the NXP network at least for the AVS
  initial setup process.
* There is also no public support for 8M for Sensory, so right now the WakeWord
  for Synaptics image is disabled.

## [imx-alexa-sdk_1.6] - 2018-04-11

### General changes

* New branch **imx-alexa-sdk** based on Morty i.MX Yocto releases.
* Move imx7d-pico kernel to version 4.9.11.
* Move imx7d-pico uboot to 2017 version.
* Remove gstreamer recipes. Gstreamer 1.10.4 is part of Morty, so no need to
  re-include them on the meta-avs-demos layer.
* AVS startup scripts (for showing NXP-Alexa ascii-art and guide you to the AVS
* Fix amixer settings (Initial volume for capture and playback) for SGTL Audio
  codec on rc.local
* Support for enabling WiFi on imx7D Pico Pi board
  The meta-picopi-wifi layer is provided separatelly by NXP.



## Known Issues/Workarounds

* Network interfaces are not enabled automatically. As a workaround enabled the
  Eth0 (for imx7-pico) and get IP by udhcpc on the local.rc service.
* NXP EULA signing at first boot was removed due to issues with StdInput=tty
  as a sytemd service.
* Remove putty due to building issues with Morty



### DSPC Specifc

* Add support for TechNexion 2-Mic VoiceHAT (pico-hat dtb)
* Add TFA98XX driver support.
* Enable asound loopback driver
* Add a meta-avs-dspc sublayer to include the spcific configurations for
  including DSPConcpets Software.
* Introduce getDSPCSoftware.sh script to fetch on runtime the audioweaver (AWE)
  binaries from DSPConcepts github repo.
* DSPConcepts license required to be accepted on runtime (by setupAvs.sh)
* Add a dummy keyword detector module for DSPC/AWE
* Enabling WakeWord detection in cloud for DSPConcepts AWE
* Add startAwe script to start the AWE Command line


## Known Issues

* The AWE Client started by startAwe.sh script takes like 40 seconds to start
  This is expected behavior provided by the DSPC licensing. So, we need to
  wait this time before launching Alexa SDK SampleApp
* The AWE Client needs to run on a separate console on foreground. The process
  does not work as expected if running on background (./startAwe &)




