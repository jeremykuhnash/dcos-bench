#!/bin/bash
## Minimal Service account delete.
## @author:     Jeremy Kuhnash <jkuhnash@mesosphere.io>
## @copyright:  2016 Mesosphere. All rights reserved.
##
##

echo "*** Make sure your logged in via 'dcos auth login'"

USER_ID="service-user"
#API_ENDPOINT="$(dcos config show core.dcos_url)/acs/api/v1/auth/login"
DCOS_URL=$(dcos config show core.dcos_url)
API_ENDPOINT="${DCOS_URL}/acs/api/v1"
AUTH_ENDPOINT="${API_ENDPOINT}/auth/login"
SERVICE_AUTH_ENDPOINT=$AUTH_ENDPOINT
# SERVICE_AUTH_ENDPOINT="https://leader.mesos/acs/api/v1/auth/login"   ### USE THIS for a Jenkins DC/OS Framework installation.
DCOS_AUTH_TOKEN=$(dcos config show core.dcos_acs_token)
WORK_DIR=`pwd`/work
DCOS_CA_CERT="${WORK_DIR}/dcos-ca.crt"
SERVICE_PUBLIC_KEY="${WORK_DIR}/service-account-public-key.pem"
SERVICE_PRIVATE_KEY="${WORK_DIR}/service-account-private-key.pem"
SERVICE_LOGIN_TOKEN_JSON="${WORK_DIR}/service-login-token.json"

mkdir ${WORK_DIR}

echo "Retrieving DCOS remote CA cert from ${DCOS_URL}"
curl -k -v ${DCOS_URL}/ca/dcos-ca.crt -o ${DCOS_CA_CERT}

# Delete user account
#curl -X DELETE --cacert ${DCOS_CA_CERT} $(dcos config show core.dcos_url)/acs/api/v1/users/${USER_ID} -d "{\"public_key\":\"${PUBLIC_KEY}\"}" -H "Content-type: application/json" -H "Authorization: token=$(dcos config show core.dcos_acs_token)"
curl -k -X DELETE ${API_ENDPOINT}/users/${USER_ID}  -H "Content-type: application/json" -H "Authorization: token=${DCOS_AUTH_TOKEN}"
