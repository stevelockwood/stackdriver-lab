#!/bin/bash

gcloud services enable container.googleapis.com 
gcloud container clusters create networklb --num-nodes 3
kubectl run nginx --image=nginx --replicas=3
kubectl expose deployment nginx --port=80 --target-port=80 --type=LoadBalancer