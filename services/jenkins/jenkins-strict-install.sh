#!/bin/bash
dcos package install --cli dcos-enterprise-cli
dcos security org service-accounts keypair jenkins-private-key.pem jenkins-public-key.pem
dcos security org service-accounts create -p jenkins-public-key.pem -d "Jenkins service account" jenkins-principal
dcos security org service-accounts show jenkins-principal
dcos security secrets create-sa-secret --strict jenkins-private-key.pem jenkins-principal jenkins/jenkins-secret

dcos package install --options=config.json jenkins
