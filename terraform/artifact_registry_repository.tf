resource "google_artifact_registry_repository" "airflow_custom_images" {
  location      = local.location
  repository_id = "airflow-custom-images"
  description   = "Airflow docker image repository"
  format        = "DOCKER"
}
