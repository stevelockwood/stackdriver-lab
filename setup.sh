#!/bin/bash

gcloud iam service-accounts create linux-servers
gcloud iam service-accounts create windows-servers
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:linux-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/logging.logWriter'
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:linux-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/monitoring.metricWriter'
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:windows-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/logging.logWriter'
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID --member=serviceAccount:windows-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role='roles/monitoring.metricWriter'
gcloud compute instances create linux-server --service-account linux-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --zone us-central1-a --metadata-from-file startup-script=linux_startup.sh
gcloud compute instances create windows-server --service-account windows-servers@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --image-project windows-cloud --image windows-server-1803-dc-core-v20180508 --zone us-central1-a --metadata-from-file windows-startup-script-ps1=windows_startup.ps1
gcloud compute instances add-tags linux-server --zone us-central1-a --tags http-server
gcloud compute firewall-rules create http-server --allow tcp:80 --target-tags http-server