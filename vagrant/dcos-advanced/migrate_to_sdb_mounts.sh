#!/bin/bash
# This script tests migrating an installed system to a new parition, mounting to /opt/mesosphere
# ready for 'reboot' testing. 


set -e
set -x

if [ -f /etc/provision_env_disk_added_date ]
then
   echo "Provision disk already done."
   exit 0
fi

/sbin/sfdisk /dev/sdb <<-'EOF'
# partition table of /dev/sdb
unit: sectors

/dev/sdb1 : start=     2048, size= 20969472, Id=83
/dev/sdb2 : start= 20971520, size= 20971520, Id=83
/dev/sdb3 : start= 41943040, size= 46137344, Id=83
EOF

mkfs.ext4 /dev/sdb1
mkdir -p /opt/mesosphere
echo '/dev/sdb1 /opt/mesosphere ext4 defaults 0 0' >> /etc/fstab
mount /opt/mesosphere

mkfs.ext4 /dev/sdb2
mkdir -p /var/lib/mesos
echo '/dev/sdb2 /var/lib/mesos ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/mesos

mkfs.ext4 /dev/sdb3
mkdir -p /var/lib/dcos
echo '/dev/sdb2 /var/lib/dcos ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/dcos

date > /etc/provision_env_disk_added_date
