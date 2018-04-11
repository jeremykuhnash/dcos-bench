#!/bin/bash

# Tested on vagrant for Mac OSX.
# Other platforms should work, but your mileage may vary.

./oel73-3.10-box/build.sh

vagrant up --no-parallel
vagrant halt bootstrap
