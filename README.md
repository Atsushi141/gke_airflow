# Overview

Create Airflow cluster on GKE along with [Rodel van Rooijen's post on Medium](https://medium.com/@rodelvanrooijen/airflow-on-gke-using-helm-15ca05c11364
) without gcloud and kubectl commands by using Terraform and helm.

A few differences are made as follows:

- Airflow WebUI is disclosed over the Internet.
- No need kubectl apply Kubernetes Persistent Volume. Compute Disk will be created by Kubernetes Persistent Volume Claim. See [Persistent volumes and dynamic provisioning](https://cloud.google.com/kubernetes-engine/docs/concepts/persistent-volumes)
 in detail.
- Logs will only be available during the lifetime of the pod. If you keep logs, see [Airflow Helm: Manage logs](https://airflow.apache.org/docs/helm-chart/stable/manage-logs.html.)
- Compute Engine Disk is not used for managing DAG files. If you want to manage DAG files well, see [Airflow Helm: Manage DAGs files](https://airflow.apache.org/docs/helm-chart/stable/manage-dags-files.html)

# Before you apply terraform

Prepare the following command line tools.

- gcloud
- docker
- kubectl
- helm

Please be aware of the following points.

- Terraform code will delete `~/.kube` directory for overwriting GKE credential. Back up `~/.kube` directory if necessary.
- GCP projects needs be created before terraform apply and all mandatory GCP APIs are enabled.

# Notes

This is not production level code in terms of the followings:

- Default VPC network should be replaced with custom VPC for security.
- CloudSQL password should be handed through in more secure way such as Secret Manager, not terraform variable.
- Terraform state file should be on GCS, not in local environment.
- Managing DAG files with Git-sync is more handy.
- Logs will only be available during the lifetime of the pod.
- And, etc...

You might use this Airflow environment for developing DAGs.

# Tricky points

- Two types of Airflow Helm chart exist. [Official Helm chart](https://airflow.apache.org/docs/helm-chart/stable/index.html#installing-the-chart) and [Community version](https://github.com/airflow-helm/charts). Use official Helm chart in this repo.

# References

[Deploying Airflow on GKE using Helm](https://medium.com/@rodelvanrooijen/airflow-on-gke-using-helm-15ca05c11364)

[Workload Identity in GKE with Terraform](https://surajblog.medium.com/workload-identity-in-gke-with-terraform-9678a7a1d9c0)

[Dynamic Provisioning and Storage Classes in Kubernetes](https://kubernetes.io/blog/2017/03/dynamic-provisioning-and-storage-classes-kubernetes/)

[Persistent volumes and dynamic provisioning](https://cloud.google.com/kubernetes-engine/docs/concepts/persistent-volumes)

[GitHub: airflow-helm/charts](https://github.com/airflow-helm/charts/blob/main/charts/airflow/examples/google-gke/custom-values.yaml)

[Apache Airflow ETL in Google Cloud](https://cloud.google.com/blog/products/data-analytics/different-ways-to-run-apache-airflow-on-google-cloud?hl=en)

[Alternative: link Kubernetes ServiceAccounts to IAM](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity#kubernetes-sa-to-iam)

[Deploying Airflow on Google Kubernetes Engine with Helm](https://towardsdatascience.com/deploying-airflow-on-google-kubernetes-engine-with-helm-28c3d9f7a26b)

[Deploying Airflow on Google Kubernetes Engine with Helm — Part Two](https://medium.com/towards-data-science/deploying-airflow-on-google-kubernetes-engine-with-helm-part-two-f833b0a3b0b1)

[Airflow Helm: Production Guide](https://airflow.apache.org/docs/helm-chart/stable/production-guide.html#database)

# Memo in technical aspects

This is just memo what I discovered during the development.

- Compute Engine Disk does not support ReadWriteMany of PVC.
- standards-rwo Storage Class does not create Compute Engine immediately after creating PVC.
