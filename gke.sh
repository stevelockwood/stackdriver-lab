#!/bin/bash

gcloud services enable container.googleapis.com
gcloud container clusters create demo-gke --num-nodes 3 --zone us-central1-a
kubectl run nginx --image=nginx --replicas=3 --port=80
kubectl expose deployment nginx --target-port=80 --type=NodePort
kubectl create -f basic-ingress.yaml
