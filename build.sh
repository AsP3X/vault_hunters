#!/bin/bash

# This script is used to build the modpack server image
# It is not intended to be run by the user

# check if the file build-info.txt is present
if [ ! -f build-info.txt ]; then
  echo "build-info.txt not found, creating it"
  touch build-info.txt
fi

# check if the file build-info.txt has the value for the modpack version
if [ -z "$(grep "modpack_version" build-info.txt)" ]; then
  echo "modpack_version not found in build-info.txt, creating it"
  echo "modpack_version=1.0.0" >> build-info.txt
else 
  echo "modpack_version found in build-info.txt"
  MODPACK_VERSION=$(grep "modpack_version" build-info.txt | cut -d "=" -f2)
fi

# check if one argument is --version or -v and if so, set the version
if [ "$1" == "--version" ] || [ "$1" == "-v" ]; then
  if [ -z "$2" ]; then
    echo "No version specified, using default value of 1.0.0"
    MODPACK_VERSION=$(grep "modpack_version" build-info.txt | cut -d "=" -f2)
  else
    echo "Version specified, using value of $2"
    MODPACK_VERSION="$2"
    # replace the version in build-info.txt
    sed -i "s/modpack_version=.*/modpack_version=$2/g" build-info.txt
  fi
fi

cd ./buildfiles
docker build -t zombymediaic/modpack:vault_hunters-$MODPACK_VERSION .