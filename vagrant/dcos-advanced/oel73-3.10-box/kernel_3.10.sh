#!/bin/bash

# 3.10 kernel for Apple
sed -i.bak s/'GRUB_DEFAULT=0'/'GRUB_DEFAULT=1'/g /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# Prep for Virtual Box Guest Additions on the 3.10 kernel
yum install -y kernel-devel
ln -s kernels/3.10.0-514.21.2.el7.x86_64/ /usr/src/linux
