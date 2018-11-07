 #!/bin/bash
 export MASTER_IP=10.10.0.19
 export USERNAME=ca
 export PASSWORD=password

 ## Put username and password in a JSON file, to be passed to the DC/OS auth API
 echo '{"uid": "USERNAME", "password": "PASSWORD"}' > login_request.json
 sed -i "s/USERNAME/${USERNAME}/" login_request.json
 sed -i "s/PASSWORD/${PASSWORD}/" login_request.json

 ## POST the JSON file to the auth login API
 curl -k https://${MASTER_IP}/acs/api/v1/auth/login \
     -X POST \
     -H 'content-type:application/json' \
     -d @login_request.json \
     > login_token.json

 ## Parse the JSON response and save the token to a text file
 cat login_token.json | python -c 'import sys,json;j=sys.stdin.read();print(json.loads(j))["token"]' > token
 rm login_request.json
 rm login_token.json

 ## Verify that you have a token
 cat token