#!/bin/bash
dcos package install --yes --cli dcos-enterprise-cli
dcos security org service-accounts keypair jenkins-private-key.pem jenkins-public-key.pem
dcos security org service-accounts create -p jenkins-public-key.pem -d "Jenkins service account" jenkins-principal
dcos security org service-accounts show jenkins-principal
dcos security secrets create-sa-secret --strict jenkins-private-key.pem jenkins-principal jenkins/jenkins-secret
dcos security secrets list /
dcos security secrets get /jenkins/jenkins-secret --json | jq -r .value | jq
curl -X PUT -k -L -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:task:user:nobody -d '{"description":"Allows Linux user nobody to execute tasks"}' -H 'Content-Type: application/json'
curl -X PUT -k -L -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:framework:role:* -d '{"description":"Controls the ability of jenkins-role to register as a framework with the Mesos master"}' -H 'Content-Type: application/json'
curl -X PUT -k -L -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:framework:role:*/users/jenkins-principal/create
curl -X PUT -k -L -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:mesos:master:task:user:nobody/users/jenkins-principal/create

dcos package install --yes --options=config.json jenkins

