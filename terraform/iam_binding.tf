locals {
  roles = {
    "roles/container.admin" = {
      members = [
        google_service_account.airflow_kubernetes.member
      ]
    }
    "roles/iam.serviceAccountUser" = {
      members = [
        google_service_account.airflow_kubernetes.member
      ]
    }
    # "roles/iam.workloadIdentityUser" = {
    #   members = [
    #     google_service_account.airflow_kubernetes.member
    #   ]
    # }
    "roles/storage.admin" = {
      members = [
        google_service_account.airflow_kubernetes.member
      ]
    }
    # "roles/owner" = {
    #   members = [
    #     google_service_account.airflow_kubernetes.member
    #   ]
    # }
  }
}

resource "google_project_iam_binding" "project" {
  for_each = local.roles

  project = data.google_project.project.project_id
  role    = each.key
  members = each.value.members
}

resource "google_project_iam_binding" "kubernetes" {
  project = data.google_project.project.project_id
  role    = "roles/iam.workloadIdentityUser"
  members = [
    google_service_account.airflow_kubernetes.member,
    "serviceAccount:${data.google_project.project.project_id}.svc.id.goog[${local.airflow_namespace}/${kubernetes_service_account.ksa.metadata[0].name}]"
  ]

  depends_on = [kubernetes_service_account.ksa]
}
