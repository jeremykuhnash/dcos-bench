#!/bin/bash

ARG_CLEAN=${1%/}
URL="${ARG_CLEAN}/acs/api/v1/auth/login"
#echo "$URL"

DCOS_AUTH_TOKEN=$( curl -k -s -X POST ${URL} -d '{"uid": "bootstrapuser", "password": "deleteme"}' -H 'Content-Type: application/json' \
| grep token | cut -d ':' -f2 | cut -d '"' -f2
)

echo $DCOS_AUTH_TOKEN

dcos config set core.dcos_acs_token $DCOS_AUTH_TOKEN

dcos node
