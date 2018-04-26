# meta-avs-demos for Alexa SDK for i.MX
---

Recipes to include Amazon's Alexa Voice Services in your applications.
---

The meta-avs-demos provides the required recipes to build an i.MX image with
the support for running Alexa SDK.

The imx-alexa-sdk branch is based on Morty and kernel 4.9.% and it supports
the next builds:


- i.MX7D Pico Pi
- i.MX8M EVK
- Generic i.MX board


For the i.MX7D Pico Pi and i.MX8M EVK there is an extended support for
additional (external) Sound Cards like:

- TechNexion VoiceHat: 2Mic Array board with DSPConcepts SW support
- Synaptics Card: 2 Mic with Sensory WakeWord support


The Generic i.MX is for any other regular i.MX board supported on the official
NXP BSP releases. Only the default soundcard (embedded) on the board is
supported.

Sensory wakeword is currently only enabled for those with ARMV7 architecture.

To support any external board like the VoiceHat or Synaptics is up to the user
to include the additional patches/changes required.


# Build Instructions

Follow the corresponding README file to follow the steps to build an image
with Alexa SDK support

 - [README-IMX7D-PICOPI.md](README-IMX7D-PICOPI.md)
 - [README-IMX8M-EVK.md](README-IMX8M-EVK.md)
 - [README-IMX-GENERIC.md](README-IMX-GENERIC.md)

---
