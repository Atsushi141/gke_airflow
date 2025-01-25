resource "null_resource" "get-credentials" {

  depends_on = [
    google_container_cluster.airflow,
    google_container_node_pool.airflow,
  ]

  provisioner "local-exec" {
    command = "rm -rf ~/.kube; gcloud container clusters get-credentials ${google_container_cluster.airflow.name} --zone=${local.zone} --project=${data.google_project.project.project_id}"
  }
}

resource "kubernetes_namespace" "airflow" {

  depends_on = [null_resource.get-credentials]

  metadata {
    name = local.airflow_namespace
  }
}
