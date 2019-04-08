#!/bin/sh
rmmod snd-soc-imx-tfa98xx
insmod /home/root/snd-soc-tfa98xx.ko fw_name="tfa98xx.cnt"
insmod /home/root/snd-soc-imx-tfa98xx.ko
