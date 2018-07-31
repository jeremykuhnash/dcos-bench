#!/usr/bin/env bash
set -x
SSH_KEY=~/.ssh/mesosphere.pem
SSH_USER=centos
MASTER_IP=34.217.55.133

if [ -f $SSH_KEY  ]; then
  ssh-add $SSH_KEY
else
  echo "Please enter a location for your SSH Key, script is exiting"
  exit -1
fi
echo "Value of SSH Key added"
echo
ssh-add -l

masters=`ssh $SSH_USER@$MASTER_IP  curl --silent leader.mesos:8181/exhibitor/v1/cluster/status` 
masterCount=`echo $masters | jq '. | length'`
leaderElected=0
leader=`ssh $SSH_USER@$MASTER_IP dig +short leader.mesos`

echo "Leading Master IP $leader"
for (( c=0; c<masterCount; c++ ))
do
  server=`echo ${masters}  |jq .[$c]`
  isLeader=`echo ${server}  |jq '. | " \(.isLeader) \(.hostname) "' | awk '{print $2}'`
  leader=`ssh $SSH_USER@$MASTER_IP dig +short leader.mesos`
  echo "Leading Master IP $leader"
  echo "SSH to Leading Master - ssh $SSH_USER@$leader"
  ssh $SSH_USER@$leader "sudo systemctl stop  dcos-mesos-master"
  sleep 20
  ssh $masterIP "sudo systemctl start  dcos-mesos-master"
  echo "Leading Master changed.."
  masters=`curl --silent leader.mesos:8181/exhibitor/v1/cluster/status | jq .`
  leaderElected=$((leaderElected+1))

  if [ $leaderElected -eq 2 ]
  then
    echo "Test Successful, Leader election occured"
    break
  fi

done
leader=`ssh $SSH_USER@$MASTER_IP dig +short leader.mesos`
echo "Leading Master IP $leader"
