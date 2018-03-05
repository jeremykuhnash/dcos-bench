#!/bin/bash
## Minimal Service account creation with new keypair, generating a JSON secret
## @author:     Jeremy Kuhnash <jkuhnash@mesosphere.io>
## @copyright:  2017 Mesosphere. All rights reserved.
##
## README:
##    * Take a look at the SERVICE_AUTH_ENDPOINT and choose the right version of the target Jenkins server.
##      Clearly, 'leader.mesos' doesn't work in an external Jenkins system, and vice versa (the Jenkins plugin will most likely hang
##      due to routing when trying to connect to an external public URL)
## WARNING : MAKE SURE TO UPDATE ENTITLEMENTS WITH SANE VALUES

echo "*** Make sure your logged in via 'dcos auth login'"

USER_ID="service-user"
#API_ENDPOINT="$(dcos config show core.dcos_url)/acs/api/v1/auth/login"
DCOS_URL=$(dcos config show core.dcos_url)
API_ENDPOINT="${DCOS_URL}/acs/api/v1"
AUTH_ENDPOINT="${API_ENDPOINT}/auth/login"
SERVICE_AUTH_ENDPOINT=$AUTH_ENDPOINT
#SERVICE_AUTH_ENDPOINT="https://leader.mesos/acs/api/v1/auth/login"   ### USE THIS for a Jenkins DC/OS Framework installation.
ACL_ENDPOINT="${DCOS_URL}/acs/api/v1/acls"
DCOS_AUTH_TOKEN=$(dcos config show core.dcos_acs_token)
WORK_DIR=`pwd`/work
DCOS_CA_CERT="${WORK_DIR}/dcos-ca.crt"
SERVICE_PUBLIC_KEY="${WORK_DIR}/service-account-public-key.pem"
SERVICE_PRIVATE_KEY="${WORK_DIR}/service-account-private-key.pem"
SERVICE_LOGIN_TOKEN_JSON="${WORK_DIR}/service-login-token.json"

echo "DCOS URL: ${DCOS_URL}"
#echo " $DCOS_AUTH_TOKEN"

echo "Refreshing Working directory."
rm -fr ${WORK_DIR}
mkdir ${WORK_DIR}

echo "Retrieving DCOS remote CA cert from ${DCOS_URL}"
curl -k -v ${DCOS_URL}/ca/dcos-ca.crt -o ${DCOS_CA_CERT}

echo "Creating a key-pair from DC/OS"
`dcos security org service-accounts keypair ${SERVICE_PRIVATE_KEY} ${SERVICE_PUBLIC_KEY}`

PUBLIC_KEY_ESCAPED=`./escape_key.py ${SERVICE_PUBLIC_KEY}`

echo "Creating User.."
echo "DCOS Cert: "
echo ${DCOS_CA_CERT}
curl -k -X PUT ${API_ENDPOINT}/users/${USER_ID} -d "{\"public_key\":\"${PUBLIC_KEY_ESCAPED}\"}" -H "Content-type: application/json" -H "Authorization: token=${DCOS_AUTH_TOKEN}"

echo "Entitling User to be a typical Mesos Framework in /dev"
declare -a acls=(
  "dcos:adminrouter:ops:mesos,full" \
  "dcos:adminrouter:ops:slave,full" \
  "dcos:adminrouter:service:marathon,full" \
  "dcos:service:marathon:marathon:services:%252Fdev,create" \
  "dcos:service:marathon:marathon:services:%252Fdev,read" \
)
for acl in ${acls[@]}; do
  PERM=`echo $acl |cut -d , -f 1`
  GRANT=`echo $acl |cut -d , -f 2`
  curl -k -X PUT ${ACL_ENDPOINT}/${PERM} -d '{"description":"Permission"}' -H "Content-type: application/json" -H "Authorization: token=${DCOS_AUTH_TOKEN}"
  PPATH="${PERM}/users/${USER_ID}/${GRANT}"
  echo "Posting to $PPATH"
  curl -k -X PUT ${ACL_ENDPOINT}/${PPATH} -d '{"description":"Permission"}' -H "Content-type: application/json" -H "Authorization: token=${DCOS_AUTH_TOKEN}"
done

echo
echo
PRIVATE_KEY_ESCAPED=`./escape_key.py ${SERVICE_PRIVATE_KEY}`
echo "JSON service account secret. Copy this text into Jenkins credentials as a 'Kind: Secret text':"
printf '{"uid":"%s","scheme":"RS256","login_endpoint":"%s","private_key":"%s"}' "${USER_ID}" "${SERVICE_AUTH_ENDPOINT}" "${PRIVATE_KEY_ESCAPED}"
printf '{"uid":"%s","scheme":"RS256","login_endpoint":"%s","private_key":"%s"}' "${USER_ID}" "${SERVICE_AUTH_ENDPOINT}" "${PRIVATE_KEY_ESCAPED}" > ${SERVICE_LOGIN_TOKEN_JSON}

echo
echo
echo "The JSON secret is available within ${SERVICE_LOGIN_TOKEN_JSON}"
