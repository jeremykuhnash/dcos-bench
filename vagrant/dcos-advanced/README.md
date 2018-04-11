This directory automates the installation of DC/OS on Oracle Linux.

Requirements:
* Internet access to obtain the base Vagrant image (one time).
* about 10GB or more of memory on the local system. This can be tweaked in the Vagrantfile.
* install virtualbox.org
* install vagrantup.com

Instructions:
* put the dcos_generate_config.ee.sh file in your ~/Downloads directory.
* cd to this directory.
* run create_oel73-3.10/build.sh
* run ./dcos-up.sh

Usage:
Access any of the nodes by using 'vagrant ssh dcosmaster' or dcosprivate, dcospublic.

After the install, try access the UI at https://localhost:1443

Testing Failures:
* To replicate the addition of a disk mount on /opt/mesosphere, uncomment the appropriate lines in the Vagrantfile.
