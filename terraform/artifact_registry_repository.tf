resource "google_artifact_registry_repository" "airflow_custom_images" {
  location      = local.location
  repository_id = "airflow-custom-images"
  description   = "Airflow docker image repository"
  format        = "DOCKER"
}


resource "null_resource" "airflow_image_push" {
  provisioner "local-exec" {
    command = <<EOF
      gcloud auth configure-docker ${local.location}-docker.pkg.dev;
      docker build docker \
        -f docker/Dockerfile \
        -t ${local.location}-docker.pkg.dev/${data.google_project.project.project_id}/airflow-custom-images/airflow-custom \
          --platform=linux/amd64;
      docker push ${local.location}-docker.pkg.dev/${data.google_project.project.project_id}/airflow-custom-images/airflow-custom;
    EOF
  }

  depends_on = [
    google_artifact_registry_repository.airflow_custom_images,
  ]
}

