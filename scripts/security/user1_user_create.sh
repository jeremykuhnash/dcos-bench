#!/bin/bash
DCOS_AUTH_TOKEN=`dcos config show core.dcos_acs_token`
DCOS_URL=$(dcos config show core.dcos_url)
API_ENDPOINT="${DCOS_URL}/acs/api/v1"
USERNAME="user1"
PASSWORD="testpassword"
curl -k -X PUT \
  -d "{\"description\": \"${USERNAME}\", \"password\": \"${PASSWORD}\"}" \
  -H "Content-type: application/json" \
  -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
  ${API_ENDPOINT}/users/${USERNAME}

# echo "Entitling User for Mesos"
# curl -k -X PUT \
#   -H "Content-type: application/json" \
#   -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
#   ${API_ENDPOINT}/acls/dcos:adminrouter:ops:mesos/users/${USERNAME}/full

# echo "Entitling User for Metrics"
# curl -k -X PUT \
#   -H "Content-type: application/json" \
#   -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
#   ${API_ENDPOINT}/acls/dcos:adminrouter:ops:system-metrics/users/${USERNAME}/full

# echo "Entitling User for Secrets path"
# curl -k -X PUT \
#   -H "Content-type: application/json" \
#   -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
#   ${API_ENDPOINT}/acls/dcos:secrets:default:users/${USERNAME}/full



# echo "*** ONLY USE FOR DEMO PURPOSES - SERVICE ACCOUNT BEING ENTITLED AS SUPERUSER"
# echo "Entitling User..."
# curl -k -X PUT \
#   -H "Content-type: application/json" \
#   -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
#   ${API_ENDPOINT}/acls/dcos:adminrouter:system:agent/users/${USERNAME}/full
