#!/bin/sh

cpufreq-set -f 1000000

echo 0  > /sys/bus/platform/devices/busfreq/enable

