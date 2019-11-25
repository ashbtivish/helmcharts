# helmcharts
Helm Charts to deploy services on GCP Cluster. 

## Initilizing Tiller on Cluster
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

### References
https://daemonza.github.io/2017/02/20/using-helm-to-deploy-to-kubernetes/

https://github.com/GoogleCloudPlatform/click-to-deploy/blob/master/k8s/jenkins/README.md

JIRA
https://hub.docker.com/u/atlassian
docker pull atlassian/jira-core
kubectl create deployment jira --image=atlassian/jira-core:latest

MONGO
docker pull mongo:latest
kubectl create deployment mongodb --image=mongo:latest

SonarQube
docker pull sonarqube:latest
kubectl create deployment sonarqube --image=docker.io/library/sonarqube:latest

Owasp
docker pull owasp/sonarqube:latest
docker.io/owasp/sonarqube:latest
kubectl create deployment jira --image=owasp/sonarqube:latest
