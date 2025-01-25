# Overview

Create Airflow cluster on GKE along with [Rodel van Rooijen's post on Medium](https://medium.com/@rodelvanrooijen/airflow-on-gke-using-helm-15ca05c11364
) using Terraform.

A few differences are made as follows:

- Airflow WebUI is disclosed over the Internet

# Notes

This is not production level code in terms of the followings:

- Using default VPC network. It should be more secure for production.
- tfstate file is on local PC.
- CloudSQL password is handed through terraform variable. It should be managed in more secure way.
- Using persistent volume for passing DAG files to Airflow. GCS would be more handy.
- StorageClass is

> ReadWriteOnce: Read and write is allowed by only one pod at a time.
> ReadWriteMany: Multiple pods can perform read & write operations from the volume.
> ReadWriteMany option is not supported in persistent volumes backed by Google persistent disk. If you have a use case to use ReadWriteMany volumes, you can consider google filestore backed persistent volumes for GKE.
https://devopscube.com/persistent-volume-google-kubernetes-engine/

 
# Tricky points


```
Because only after a pod is created with a PVC request, kubernetes creates the persistent volume
```

https://devopscube.com/persistent-volume-google-kubernetes-engine/

# References

https://medium.com/@rodelvanrooijen/airflow-on-gke-using-helm-15ca05c11364

https://surajblog.medium.com/workload-identity-in-gke-with-terraform-9678a7a1d9c0

https://kubernetes.io/blog/2017/03/dynamic-provisioning-and-storage-classes-kubernetes/
