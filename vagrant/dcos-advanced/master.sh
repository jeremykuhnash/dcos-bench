#!/bin/bash
# Not used any longer erplaced with persistent-storage plugin
set -e
set -x

mkdir /tmp/dcos && cd /tmp/dcos
curl -O http://192.168.56.100/dcos_install.sh
# remove 'check_preexisting_dcos' from script.
sed -i -e '350d' dcos_install.sh
sudo bash dcos_install.sh master
