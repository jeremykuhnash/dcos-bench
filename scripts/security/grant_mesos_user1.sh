#!/bin/bash

#dcos security org users grant user1 dcos:adminrouter:ops:slave full --description "Controls access to task details such as logs"

dcos security org users grant user1 dcos:adminrouter:ops:mesos full --description "Controls access to task details"
dcos security org users grant user1 dcos:adminrouter:ops:system-metrics full
dcos security org users grant user1 dcos:adminrouter:system:agent full
