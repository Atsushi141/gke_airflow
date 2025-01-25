terraform {
  required_providers {
    google = "~>6.17.0"
  }
}

variable "project" {
  type = string
}

provider "google" {
  project = var.project
  region  = "us-central1"
  zone    = "us-central1-a"
}

data "google_client_config" "google_client" {}

provider "kubernetes" {
  host  = "https://${google_container_cluster.airflow.endpoint}"
  token = data.google_client_config.google_client.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.airflow.master_auth.0.cluster_ca_certificate
  )
}

data "google_project" "project" {}

locals {
  location = "us-central1"
  zone     = "us-central1-a"
}
