#!/bin/bash

# Tested on vagrant for Mac OSX.
# Other platforms should work, but your mileage may vary.

./create_oel73-3.10/build.sh

vagrant up --no-parallel
vagrant halt bootstrap
