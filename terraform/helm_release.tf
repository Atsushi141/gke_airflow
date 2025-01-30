# https://cloud.google.com/blog/ja/products/data-analytics/different-ways-to-run-apache-airflow-on-google-cloud
data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.airflow.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.airflow.master_auth.0.cluster_ca_certificate)
  }
}

resource "helm_release" "airflow" {
  name             = "airflow"
  repository       = "https://airflow.apache.org"
  chart            = "airflow"
  version          = "1.9.0"
  namespace        = "airflow"
  create_namespace = false
  wait             = false
  values = [templatefile("helm/values.yaml", {
    dbUser     = google_sql_user.airflow.name,
    dbPass     = google_sql_user.airflow.password,
    dbHost     = google_sql_database_instance.airflow.private_ip_address,
    dbDatabase = google_sql_database.airflow.name
  })]

  depends_on = [
    google_container_cluster.airflow,
  ]
}
