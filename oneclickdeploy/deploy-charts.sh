#!/bin/sh

clear

echo "Applying CRD"
kubectl apply -f "https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml"

echo "Logging to Google Docker Registry"
gcloud auth configure-docker

echo "Intializing Environment Variables"
export CLUSTER=k8s-cluster
export ZONE=us-central1-a

echo "Logging to GCP Cluster"
gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE"

echo "Creating Tiller service account"
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts;

#kubectl create secret docker-registry chart-example-tls --docker-server=$DOCKER_REGISTRY_RUL --docker-username=ashish --docker-password=abc123 --docker-email=xyz@abc.com

echo "Upgrading server Tiller version"
helm init --upgrade

echo "Testing Helm chart for Syntax using lint"
helm lint oneclickdeploy

echo "Creating Helm Package"
helm package oneclickdeploy

echo "Removing previous release if exist"
helm del --purge oneclickdeploy

sleep 5

echo "Deploying the Helm release"
helm install oneclickdeploy-0.1.0.tgz --name oneclickdeploy

#helm del --purge jenkins-gcp