#!/bin/bash

curl -i \
      -u <operator_principal>:<password> \
      -d slaveId=<slave_id> \
      -d resources='[
        {
          "name": "cpus",
          "type": "SCALAR",
          "scalar": { "value": 8 },
          "role": "ads",
          "reservation": {
            "principal": <operator_principal>
          }
        },
        {
          "name": "mem",
          "type": "SCALAR",
          "scalar": { "value": 4096 },
          "role": "ads",
          "reservation": {
            "principal": <operator_principal>
          }
        }
      ]' \
      -X POST http://<ip>:<port>/mesos/slaves/reserved_resources_full
