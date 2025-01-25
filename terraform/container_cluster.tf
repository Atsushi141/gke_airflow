resource "google_container_cluster" "airflow" {
  name                     = "airflow-cluster"
  location                 = local.zone # Should be region in production
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"
  remove_default_node_pool = true

  cluster_autoscaling {
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
  deletion_protection = false
}

resource "google_container_node_pool" "airflow" {
  name       = "airflow-cluster-pool"
  location   = local.zone
  cluster    = google_container_cluster.airflow.name
  node_count = 1

  node_config {
    machine_type = "n2-standard-4"

    service_account = google_service_account.airflow_kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  depends_on = [google_container_cluster.airflow]
}
