#!/bin/bash

export DISPLAY=:0.0
/home/root/Alexa_SDK/Scripts/setUTCTime.sh

echo "============================================================ "
echo " Now we will try to authenticate your AVS device             "
echo ""

pip install commentjson > /dev/null 2>&1


cd /home/root/Alexa_SDK/avs-sdk-client/
python AuthServer/AuthServer.py > /dev/null 2>&1 &
pid=$!
trap 'kill $pid; exit' SIGINT

sleep 7

kill -0 $pid > /dev/null 2>&1
if [ ! $? -eq 0 ]
then
echo ""
echo " You already have a valid Token"
echo "============================================================ "
 exit 0
fi

location=$(curl -I http://127.0.0.1:3000/  2>&1 | grep Location | awk '{ print $2 }')

echo ""
echo ""
echo " Please Copy the next long URL on your PC browser "
echo ""
echo ""
echo "  $location"
echo ""
echo ""
echo " Login with your AVS Credentials and you will be redirectioned
echo " to an URL like:
echo ""
echo "  http://localhost:3000/authresponse?code=<SomeLongCodeHere=alexa%3Aall>"
echo ""
echo ""
echo " This is the authresponse URL that indicates a succesfull AVS"
echo " authentication of your credentials"
echo ""
echo " Copy from your PC your authentication URL, similar to the one"
echo " above and paste it below:"
echo ""
echo ""
echo "================================================================== "

while read -r -t 0; do read -r; done
read -p "Enter your authresponse URL here: " usrInput

curl $usrInput

echo ""
echo ""
echo "============================================================ "
