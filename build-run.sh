#!/bin/bash
docker run -e ENV_DCOS_USER=$ENV_DCOS_USER \
  -e ENV_DCOS_PASSWORD=$ENV_DCOS_PASSWORD \
  -e ENV_URL=$ENV_URL \
  -it `docker build . |grep built | cut -f 3 -d " "`
