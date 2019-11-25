#!/bin/sh

kubectl apply -f "https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml"
gcloud auth configure-docker

export CLUSTER=k8s-cluster
export ZONE=us-central1-a

export TLS_CERTIFICATE_KEY="$(cat /tmp/tls.key | base64)"
export TLS_CERTIFICATE_CRT="$(cat /tmp/tls.crt | base64)"

gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE"

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts;

#kubectl create secret docker-registry chart-example-tls --docker-server=$DOCKER_REGISTRY_RUL --docker-username=ashish --docker-password=abc123 --docker-email=xyz@abc.com

helm init --upgrade
helm package jira

helm install jira-0.1.0.tgz --name jira-gcp #--key TLS_CERTIFICATE_KEY --crt TLS_CERTIFICATE_CRT

#helm del --purge jira-gcp
