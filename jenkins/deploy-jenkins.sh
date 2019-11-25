#!/bin/sh

kubectl apply -f "https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml"
gcloud auth configure-docker

export CLUSTER=k8s-cluster
export ZONE=us-central1-a
export APP_INSTANCE_NAME=auto-jenkins
export NAMESPACE=default
export TAG=2.190

gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE"

export IMAGE_JENKINS="marketplace.gcr.io/google/jenkins:${TAG}"
export IMAGE_JENKINS=$(docker pull $IMAGE_JENKINS | awk -F: "/^Digest:/ {print gensub(\":.*$\", \"\", 1, \"$IMAGE_JENKINS\")\"@sha256:\"\$3}")

echo $IMAGE_JENKINS

export TLS_CERTIFICATE_KEY="$(cat /tmp/tls.key | base64)"
export TLS_CERTIFICATE_CRT="$(cat /tmp/tls.crt | base64)"

helm template chart/jenkins \
	  --name $APP_INSTANCE_NAME \
	    --namespace $NAMESPACE \
	      --set "jenkins.image=$IMAGE_JENKINS" \
	        --set "tls.base64EncodedPrivateKey=$TLS_CERTIFICATE_KEY" \
		  --set "tls.base64EncodedCertificate=$TLS_CERTIFICATE_CRT" \
		    > ${APP_INSTANCE_NAME}_manifest.yaml

kubectl apply -f "${APP_INSTANCE_NAME}_manifest.yaml" --namespace "${NAMESPACE}"

echo "https://console.cloud.google.com/kubernetes/application/${ZONE}/${CLUSTER}/${NAMESPACE}/${APP_INSTANCE_NAME}"

EXTERNAL_IP=$(kubectl -n$NAMESPACE get ingress -l "app.kubernetes.io/name=$APP_INSTANCE_NAME" \
	  -ojsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")
MASTER_POD=$(kubectl -n$NAMESPACE get pod -oname | sed -n /\\/$APP_INSTANCE_NAME-jenkins/s.pods\\?/..p)

echo $EXTERNAL_IP
echo $MASTER_POD
echo "https://${EXTERNAL_IP}/"
