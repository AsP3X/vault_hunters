#!/bin/bash

# This script is used to start the modpack server image
# It is not intended to be run by the user

# get filename of the forge jar in /serverfiles
FORGEJAR=$(ls /serverfiles/forge-*.jar)
mv $FORGEJAR /serverfiles/forge.jar

# check if the run.sh script is already in /server
if [ ! -f /server/$FORGEJAR ]; then
  cp -r /serverfiles/* /server
  cp -r /temp/config /server/config
  cp -r /temp/defaultconfigs /server/defaultconfigs
  cp -r /temp/mods /server/mods
  cp -r /temp/openloader /server/openloader
  cp -r /temp/scripts /server/scripts
  cp /temp/server-icon.png /server/server-icon.png
  cp /temp/server.properties /server/server.properties
  cp /temp/start.sh /server/start.sh
fi

# check if the RAM variable is set
if [ -z "$RAM" ]; then
  echo "RAM variable not set, using default value of 4G"
  RAM="6G"
else
  echo "RAM variable set to $RAM"
fi

# check if the eula.txt is located in /server
if [ ! -f /server/eula.txt ]; then
  echo "eula.txt not found, creating it"
  echo "eula=true" > /server/eula.txt
fi

# if [[ ! -s "/server/user_jvm_args.txt" ]]; then
#   {
#     echo "# Xmx and Xms set the maximum and minimum RAM usage, respectively."
#     echo "# They can take any number, followed by an M or a G."
#     echo "# M means Megabyte, G means Gigabyte."
#     echo "# For example, to set the maximum to 3GB: -Xmx3G"
#     echo "# To set the minimum to 2.5GB: -Xms2500M"
#     echo "# A good default for a modded server is 4GB."
#     echo "# Uncomment the next line to set it."
#     echo "# -Xmx4G"
#     echo "-Xmx8G"
#   } >>user_jvm_args.txt

# else
#   echo "user_jvm_args.txt present..."
# fi

# start the server
cd /server

screen -S gameserver /bin/sh -c "java -Xmx${RAM} -Xms2048M -jar forge.jar"