#!/bin/bash

# get apache ip
export APACHE_IP=$(gcloud compute instances describe linux-server-$DEVSHELL_PROJECT_ID --zone us-central1-a --format json | jq -r .networkInterfaces[0].accessConfigs[0].natIP)

# generate apache 200s
nohup watch curl http://35.193.136.174/ &

# generate apache 404s
nohup watch curl http://35.193.136.174/missing.html &

# generate apache 403s
nohup watch curl http://35.193.136.174/secure.html &

# get load balancer ip


# generate nginx 200s
# watch curl http://apacheip

# generate nginx 404s
# watch curl http://apacheip/missing.html

# generate nginx 403s
# watch curl http://apacheip/secured.html

# generate pubsub activity
