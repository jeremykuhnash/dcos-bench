[ -d /usr/local/bin ] || sudo mkdir -p /usr/local/bin && 
curl https://downloads.dcos.io/binaries/cli/darwin/x86-64/dcos-1.11/dcos -o dcos && 
sudo mv dcos /usr/local/bin && 
sudo chmod +x /usr/local/bin/dcos && 
dcos cluster setup https://jkuhnash-elasticl-1n6so7sc10r74-303559202.us-west-2.elb.amazonaws.com && 
dcos
