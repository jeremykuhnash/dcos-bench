#!/bin/bash
DCOS_AUTH_TOKEN=`dcos config show core.dcos_acs_token`
DCOS_URL=$(dcos config show core.dcos_url)
API_ENDPOINT="${DCOS_URL}/acs/api/v1"


# echo "Entitling User for Metrics"
# curl -k -X PUT \
#   -H "Content-type: application/json" \
#   -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
#   ${API_ENDPOINT}/acls/dcos:adminrouter:ops:system-metrics/users/${USERNAME}/full

echo "ACL JSON payload for Metrics ACL:"
curl -k -X GET \
  -H "Content-type: application/json" \
  -H "Authorization: token=${DCOS_AUTH_TOKEN}" \
  ${API_ENDPOINT}/acls/dcos:adminrouter:ops:system-metrics/


  