#!/bin/bash
dcos marathon pod add metrics.json
dcos marathon app add prometheus.json
dcos marathon app add grafana.json
