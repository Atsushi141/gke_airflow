locals {
  airflow_namespace = "airflow"
}

resource "kubernetes_service_account" "ksa" {
  metadata {
    name      = "airflow"
    namespace = local.airflow_namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.airflow_kubernetes.email
    }
  }

  depends_on = [kubernetes_namespace.airflow]
}
