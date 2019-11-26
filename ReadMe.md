# HelmCharts

The project constitute of Helmchart to deploy JIRA, JENKINS, OwaspSonarQube & MongoDB on Google K8s Cluster

## Pre-requisites

1. GCP K8s Cluster (Node: 2 cpu & 7.5 Gi)
2. Cloud SDK
3. KubeCTL
4. Helm

## Execution

Initialize below Environment Variables before executing the file deploy-charts.sh file
ReleaseName is optional if not provided helm will choose automatically. use lowercase letters in release name

```bash
export CLUSTER=k8s-cluster
export ZONE=us-central1-a
export ReleaseName=oneclickdeploy
```

Verify the environment variables using echo command

```shell
    echo $CLUSTER
    echo $ZONE
    echo $ReleaseName
```

Now execute the script to start the deployment

```bash
./deploy-charts.sh
```
