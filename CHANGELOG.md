# Change Log/Release Notes

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

