#!/bin/sh

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo ""
echo "===================================================================="
echo " Please provide the following info of your AVS device               "
echo " You can get your info from https://developer.amazon.com/home.html  "
echo "===================================================================="
echo ""

AVS_SDK_DIR="/home/root/Alexa_SDK/avs-sdk-client"
AVS_SOURCE_DIR="/home/root/Alexa_SDK/avs-device-sdk"
SDK_CONFIG_FILE="Integration/AlexaClientSDKConfig.json"
AVS_CONF="/etc/alexa_sdk/avs.conf"

SDK_CONFIG_PRODUCT_ID="my_device"
SDK_CONFIG_CLIENT_ID="amzn1.application-oa2-client.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
SDK_CONFIG_DEVICE_SERIAL_NUMBER="123456"
SDK_SQLITE_DATABASE_FILE_PATH="/database/myAlertsDatabase"
SDK_SQLITE_SETTINGS_DATABASE_FILE_PATH="/database/mySettingsDatabase"
SETTING_LOCALE_VALUE="en-US"
SDK_CERTIFIED_SENDER_DATABASE_FILE_PATH="/database/myCertDatabase"
SDK_NOTIFICATIONS_DATABASE_FILE_PATH="/database/myNotifDatabase"
SDK_CBL_AUTH_DELEGATE_DATABASE_FILE_PATH="/database/myCblAuthDelDatabase"
SDK_MISC_DATABASE_FILE_PATH="/database/myMiscDatabase"

if [ -f $SDK_CBL_AUTH_DELEGATE_DATABASE_FILE_PATH ]; then
    rm $SDK_CBL_AUTH_DELEGATE_DATABASE_FILE_PATH
fi

echo -e "${YELLOW}"
echo "============================= WARNING ============================== "
echo ""
echo " From SDK Version 1.7 and so on, the Client ID captured is from the  "
echo " \"Other devices and platforms\" tab within the Security Profile     "
echo " section, and NOT the Client ID from the \"Web\" tab as it used to be"
echo ""
echo "==================================================================== "
echo -e "${NC}"

while true; do

if [ -r "$AVS_CONF" ]; then
        array=($(<$AVS_CONF))

        SDK_CONFIG_PRODUCT_ID=${array[0]}
        SDK_CONFIG_CLIENT_ID=${array[1]}
        SETTING_LOCALE_VALUE=${array[2]}
fi

  cp $AVS_SOURCE_DIR/$SDK_CONFIG_FILE $AVS_SDK_DIR/$SDK_CONFIG_FILE

  sed -e "s#\${SDK_CONFIG_DEVICE_SERIAL_NUMBER}#${SDK_CONFIG_DEVICE_SERIAL_NUMBER}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE
  sed -e "s#\${SDK_SQLITE_DATABASE_FILE_PATH}#${SDK_SQLITE_DATABASE_FILE_PATH}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE
  sed -e "s#\${SDK_SQLITE_SETTINGS_DATABASE_FILE_PATH}#${SDK_SQLITE_SETTINGS_DATABASE_FILE_PATH}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE
  sed -e "s#\${SDK_CERTIFIED_SENDER_DATABASE_FILE_PATH}#${SDK_CERTIFIED_SENDER_DATABASE_FILE_PATH}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE
  sed -e "s#\${SDK_NOTIFICATIONS_DATABASE_FILE_PATH}#${SDK_NOTIFICATIONS_DATABASE_FILE_PATH}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE
  sed -e "s#\${SDK_CBL_AUTH_DELEGATE_DATABASE_FILE_PATH}#${SDK_CBL_AUTH_DELEGATE_DATABASE_FILE_PATH}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE
  sed -e "s#\${SDK_MISC_DATABASE_FILE_PATH}#${SDK_MISC_DATABASE_FILE_PATH}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

  while read -r -t 0; do read -r; done

  read -p "Enter your Product ID[$SDK_CONFIG_PRODUCT_ID]: " usrInput
  echo "${usrInput:-$SDK_CONFIG_PRODUCT_ID}" > $AVS_CONF
  sed -e "s#\${SDK_CONFIG_PRODUCT_ID}#${usrInput:-$SDK_CONFIG_PRODUCT_ID}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

  read -p "Enter your Clent Id[$SDK_CONFIG_CLIENT_ID]: " usrInput
  echo "${usrInput:-$SDK_CONFIG_CLIENT_ID}" >> $AVS_CONF
  sed -e "s#\${SDK_CONFIG_CLIENT_ID}#${usrInput:-$SDK_CONFIG_CLIENT_ID}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

  read -p "Enter your preferred locale (en-US, en-GB, de-DE, en-IN, en-CA, ja-JP, en-AU)[$SETTING_LOCALE_VALUE]: " usrInput
  echo "${usrInput:-$SETTING_LOCALE_VALUE}" >> $AVS_CONF
  sed -e "s#\${SETTING_LOCALE_VALUE}#${usrInput:-$SETTING_LOCALE_VALUE}#g" -i $AVS_SDK_DIR/$SDK_CONFIG_FILE

  read -p "Are your Settings OK [Y/N]? " usrInput
  case $usrInput in
      [Yy]* )  break;;
      [Nn]* )  ;;
      * ) echo "Please answer yes or no.";;
  esac

done

