resource "google_service_account" "airflow_kubernetes" {
  account_id   = "airflow-kubernetes"
  display_name = "Service Account"
  description  = "User-managed service account for the Airflow deployment"
}
