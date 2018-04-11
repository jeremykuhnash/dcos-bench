#!/bin/bash

ssh -i ~/keys/aws-remote.pem -R 8000:127.0.0.1:8000 ec2-user@18.221.152.110 -N
