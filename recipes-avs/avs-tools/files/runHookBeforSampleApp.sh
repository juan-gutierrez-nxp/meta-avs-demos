#!/bin/sh

cpufreq-set -f 800000

echo 0  > /sys/bus/platform/devices/busfreq/enable

