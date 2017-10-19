#!/bin/bash
echo ""
echo "===================================================================="
echo " Please provide the following info of your AVS device               "
echo " You can get your info from https://developer.amazon.com/home.html  "
echo "===================================================================="
echo ""

AVS_SDK_DIR="/home/root/Alexa_SDK/avs-sdk-client"
SDK_CONFIG_FILE="Integration/AlexaClientSDKConfig.json"
AVS_CONF="/etc/alexa_sdk/avs.conf"

AVS_PRODUCT_ID="my_device"
AVS_CLIENT_ID="amzn1.application-oa2-client.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
AVS_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

while true; do

if [ -r "$AVS_CONF" ]; then
        array=($(<$AVS_CONF))

        AVS_PRODUCT_ID=${array[0]}
        AVS_CLIENT_ID=${array[1]}
        AVS_CLIENT_SECRET=${array[2]}
fi

  cp /etc/alexa_sdk/AlexaClientSDKConfig.json.Original $AVS_SDK_DIR/$SDK_CONFIG_FILE

  while read -r -t 0; do read -r; done

  read -p "Enter your Product ID[$AVS_PRODUCT_ID]: " usrInput
  echo "${usrInput:-$AVS_PRODUCT_ID}" > $AVS_CONF
  sed -e "s/SDK_CONFIG_DEVICE_TYPE_ID/${usrInput:-$AVS_PRODUCT_ID}/g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

  read -p "Enter your Clent Id[$AVS_CLIENT_ID]: " usrInput
  echo "${usrInput:-$AVS_CLIENT_ID}" >> $AVS_CONF
  sed -e "s/SDK_CONFIG_CLIENT_ID/${usrInput:-$AVS_CLIENT_ID}/g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

  read -p "Enter your Client Secret[$AVS_CLIENT_SECRET]: " usrInput
  echo "${usrInput:-$AVS_CLIENT_SECRET}" >> $AVS_CONF
  sed -e "s/SDK_CONFIG_CLIENT_SECRET/${usrInput:-$AVS_CLIENT_SECRET}/g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

   read -p "Are your Credential OK [Y/N]? " usrInput
    case $usrInput in
        [Yy]* )  break;;
        [Nn]* )  ;;
        * ) echo "Please answer yes or no.";;
    esac
done

