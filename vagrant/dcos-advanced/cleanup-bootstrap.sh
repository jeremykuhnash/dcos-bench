#!/bin/bash

#set -e
#set -x

ln -s /local/genconf /root/genconf
cd /root
rm -fR genconf/serve
rm -f genconf/cluster_packages.json
rm -fR genconf/state
bash /downloads/dcos_generate_config.ee.sh
docker run -d -p 80:80 -v $PWD/genconf/serve:/usr/share/nginx/html:ro nginx
