#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Cleaning up..."
rm -f ${DIR}/oel73_3.10.box
vagrant destroy -f
rm -fR ${DIR}/.vagrant

VM="${HOME}/VirtualBox\ VMs/ol*"
if [ -d "$VM" ]; then
  while true; do
      read -p "Do you wish to delete $VM?  " yn
      case $yn in
          [Yy]* ) echo Removing... ; break;;
          [Nn]* ) exit;;
          * ) echo "Please answer yes or no.";;
      esac
  done
  rm -fR $VM
fi
