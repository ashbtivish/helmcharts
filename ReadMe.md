# HelmCharts

The project constitutes of Helmchart to deploy JIRA, JENKINS, OwaspSonarQube & MongoDB on Google K8s Cluster

## Pre-requisites

* K8s Cluster in Google Cloud Platform, with minimum node configuration of 2 cpu,  7.5 GB memory and 100 GB storage

* Cloud SDK need to be installed along with components kubectl & docker-credential-gcr

* Helm package must be installed

## Execution

Initialize below Environment variables before executing the file deploy-charts.sh

```bash
export CLUSTER=k8s-cluster
export ZONE=us-central1-a
export ReleaseName=oneclickdeploy
```

ReleaseName is optional if not provided helm will choose automatically. use lowercase letters in release name. You can verify the environment variables using echo command

```shell
    echo $CLUSTER
    echo $ZONE
    echo $ReleaseName
```

Now execute the script to start the deployment

```bash
./deploy-charts.sh
```

## Workloads available

* Jenkins
* Jira
* MongoDB
* SonarQube

## Screenshot Post-deployment

### Execution of the Deployment script

![MissingImage](https://raw.github.com/ashbtivish/helmcharts/master/resources/DeploymentScript.jpg "Execution Screenshot")

### Workloads created on GCP Cluster

![MissingImage](https://raw.github.com/ashbtivish/helmcharts/master/resources/workloads.JPG "GCP Workload")

#### Services and Endpoints created on GCP Cluster

![MissingImage](https://raw.github.com/ashbtivish/helmcharts/master/resources/services.JPG "GCP Service")

#### Launch Jenkins after creation of Service and endpoint

![MissingImage](https://raw.github.com/ashbtivish/helmcharts/master/resources/jenkins.JPG "Jenkins Service")

#### Launch SonarQube after creation of Service and endpoint

![MissingImage](https://raw.github.com/ashbtivish/helmcharts/master/resources/sonarqube.JPG "SonarQube Service")

## References

* https://docs.kublr.com/installation/gcp/gcp/
* https://hub.docker.com
