#!/bin/sh

if [ !$(lsmod | grep "snd_soc_tfa98xx") ]
then
	echo "load TFA98xx driver first"
	exit 1
fi

# Save logs under ./test_logs directory
if [ ! -d "/home/root/test_logs" ]
then
	mkdir /home/root/test_logs
fi

FILEPREFIX=${RANDOM}_playrec
LOG_FILE=/home/root/test_logs/${FILEPREFIX}_playrec.log

# Reduce gain before playback
/home/root/climax -d /dev/i2c-1 -l /lib/firmware/tfa98xx.cnt VOL=40

a=0

while [ $a -lt 10 ]
do
	echo "Iteration ${a}"
	aplay -Dhw:2,0 480Hz_2ch_30s.wav &
	PID_PLAY=$!
	sleep 2 
	for j in 1 2 3 4 5
	do
		echo "*** Iteration ${a}.${j}"
		arecord -Dhw:2,0 -c 2 -f S16_LE -r 48000 -d 60 /home/root/test_logs/${FILEPREFIX}_${a}_${j}_AEC.wav &
		sleep 2
		echo $(date) >> $LOG_FILE
		/home/root/climax -d /dev/i2c-1 -l /lib/firmware/tfa98xx.cnt MANSCONF >> $LOG_FILE
		sleep 2 
		# Kill rec
		echo "## Killing arecord" 
		killall arecord
		echo "## Checking arecord termination"
		while pgrep arecord 
		do
			echo "## Kill one more time"
			killall arecord
			sleep 2
		done
		sync
	done
	echo "-- Killing aplay"
	killall aplay
	echo "-- Checking aplay terminated"
	while pgrep aplay 
        do
        	echo "## Kill one more time"
                killall aplay
                sleep 2
        done
	a=`expr $a + 1` 
done
# Restore gain
/home/root/climax -d /dev/i2c-1 -l /lib/firmware/tfa98xx.cnt VOL=0

