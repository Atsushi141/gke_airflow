resource "kubernetes_persistent_volume_claim" "airflow" {
  metadata {
    name      = "airflow-dags-pvc"
    namespace = local.airflow_namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    # volume_name        = "airflow-dags-disk" caution!!!
    storage_class_name = "standard"
  }

  depends_on = [
    kubernetes_service_account.ksa,
  ]
}
