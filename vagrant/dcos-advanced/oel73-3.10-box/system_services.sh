#!/bin/bash

yum install -y ntp
systemctl start ntpd
systemctl enable ntpd
yum install -y unzip
groupadd nogroup
