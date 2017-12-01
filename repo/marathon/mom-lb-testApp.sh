#!/bin/bash

dcos marathon app add ./mom-full/marathon-user.json
dcos marathon app add ./lb/marathon-lb.json
dcos config set marathon.url $(dcos config show core.dcos_url)/service/marathon-user
dcos marathon app add ./apps/test/tracer-external-trace1.json
dcos config unset marathon.url
