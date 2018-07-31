#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Please supply an argument string for the command to be run on Private Agents."
    exit 1
fi

PRIVATE_AGENTS=$(dcos node --json | jq --raw-output '.[] | select(.attributes.public_ip != "true") | .id')

echo "Arg: $1"

for id in ${PRIVATE_AGENTS[@]}; do
  echo "Working on: $id"
  CMD="dcos node ssh --option StrictHostKeyChecking=no --option LogLevel=quiet --master-proxy --user=centos --mesos-id=$id"
  #echo "Running $CMD"
  RETVAL=`$CMD "$1"`
  echo "Retval: $RETVAL"
done 2>/dev/null
