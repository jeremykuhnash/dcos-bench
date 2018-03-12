#!/bin/bash
DCOS_AUTH_TOKEN=`dcos config show core.dcos_acs_token`
DCOS_URL=$(dcos config show core.dcos_url)
API_ENDPOINT="${DCOS_URL}/acs/api/v1"
ADMIN_NAME="administrator"
curl -L -k -X PUT \
  -d "{\"description\": \"${ADMIN_NAME}\", \"password\": \"admin098\"}" \
  -H "Content-type: application/json" \
  -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
  ${API_ENDPOINT}/users/${ADMIN_NAME}

echo "*** ONLY USE FOR DEMO PURPOSES - SERVICE ACCOUNT BEING ENTITLED AS SUPERUSER"
echo "Entitling User..."
curl -L -k -X PUT \
  -H "Content-type: application/json" \
  -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
  ${API_ENDPOINT}/acls/dcos:superuser/users/${ADMIN_NAME}/full
