#!/bin/bash

if [ $# -ne 0 ]; then
	USER_ID="$1"
else
	USER_ID="core"
fi

PUBLIC_AGENTS=$(dcos node --json | jq --raw-output '.[] | select(.attributes.public_ip == "true") | .id')

for id in ${PUBLIC_AGENTS[@]}; do
	echo "Mesos ID: $id" 
	IP=`dcos node ssh --option StrictHostKeyChecking=no --option LogLevel=quiet --master-proxy --user=$USER_ID --mesos-id=$id "curl ifconfig.co"`
	echo $IP
done
#done 2>/dev/null
