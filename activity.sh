#!/bin/bash

# get apache ip
export APACHE_IP=$(gcloud compute instances describe linux-server-$DEVSHELL_PROJECT_ID --zone us-central1-a --format json | jq -r .networkInterfaces[0].accessConfigs[0].natIP)

# generate apache 200s
nohup watch curl http://$APACHE_IP/ &

# generate apache 404s
nohup watch curl http://$APACHE_IP/missing.html &

# generate apache 403s
nohup watch curl http://$APACHE_IP/secure.html &

# get load balancer ip
GKE_IP=""
while [ $GKE_IP == "" ]; do
  export GKE_IP=$(gcloud compute forwarding-rules list --global --format json | jq -r .[0].IPAddress)
  sleep 2
done

# generate nginx 200s
nohup watch curl http://$GKE_IP/ &

# generate nginx 404s
nohup watch curl http://$GKE_IP/missing.html &

# generate pubsub activity
nohup watch -n 0.5 gcloud pubsub topics publish demo-topic --message "demo" &

sleep 3
echo 'Activity underway!'
