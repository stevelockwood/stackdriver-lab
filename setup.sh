#!/bin/bash

gcloud iam service-accounts create linux-servers --display-name linux-servers
gcloud iam service-accounts create windows-servers --display-name windows-servers
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:linux-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/logging.logWriter'
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:linux-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/monitoring.metricWriter'
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:windows-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/logging.logWriter'
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:windows-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/monitoring.metricWriter'
gcloud compute instances create linux-server-$DEVSHELL_PROJECT_ID --service-account linux-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --zone us-central1-a --metadata-from-file startup-script=linux_startup.sh
gcloud compute instances create windows-server-$DEVSHELL_PROJECT_ID --service-account windows-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --image-project windows-cloud --image windows-server-1803-dc-core-v20180508 --zone us-central1-a --metadata-from-file windows-startup-script-ps1=windows_startup.ps1
gcloud compute instances add-tags linux-server-$DEVSHELL_PROJECT_ID --zone us-central1-a --tags http-server
gcloud compute firewall-rules create http-server --allow tcp:80 --target-tags http-server
gcloud services enable compute.googleapis.com  
gcloud service enable container.googleapis.com 
gcloud service enable sqladmin.googleapis.com
gcloud enable sql-component.googleapis.com
gcloud enable pubsub.googleapis.com
