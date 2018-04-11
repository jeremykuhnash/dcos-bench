#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BOX="oel73_3.10"
BOX_FILE="${THIS_DIR}/${BOX}.box"
BOX_URL="https://s3-us-west-2.amazonaws.com/jkuhnash-customers/${BOX}.box"
ATLAS_NAME="jeremykuhnash/${BOX}"

if [ ! -f "${BOX_FILE}" ]; then
  echo "Building the box image locally, please wait..."
  # 1) vagrant up builds the base image
  # 2) vagrant halt stops it
  # 3) vagrant up installs new vbguest tools, again.
  # 4) vagrant halt stops it for exporting
  # 5) vagrant package boxes it up for consumption down the road...
  #vagrant up && vagrant halt && vagrant up && vagrant halt && vagrant package --base oel73_3.10 --output ${BOX_FILE}
  echo "Downloading image from dropbox. Alternatively, to build from scratch run vagrant up && vagrant halt && vagrant up && vagrant halt && vagrant package --base oel73_3.10 --output ${BOX_FILE} in this directory. "
  curl -C - -o ${THIS_DIR}/${BOX}.box ${BOX_URL}
  vagrant box add --force $ATLAS_NAME file://${THIS_DIR}/${BOX_FILE}
fi
