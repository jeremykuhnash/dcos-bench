#!/bin/bash


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
  curl -k -X PUT ${API_ENDPOINT}/acls/${PERM} -d '{"description":"Permission"}' -H "Content-type: application/json" -H "Authorization: token=${DCOS_AUTH_TOKEN}"
  PPATH="${PERM}/users/${USER_ID}/${GRANT}"
  echo "Posting to $PPATH"
  curl -k -X PUT ${API_ENDPOINT}/acls/${PPATH} -d '{"description":"Permission"}' -H "Content-type: application/json" -H "Authorization: token=${DCOS_AUTH_TOKEN}"
done

