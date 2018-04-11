#!/bin/bash

mkdir /tmp/dcos && cd /tmp/dcos
curl -O http://192.168.56.100/dcos_install.sh
# remove 'check_preexisting_dcos' from script.
sed -i -e '350d' dcos_install.sh
sudo bash dcos_install.sh slave
