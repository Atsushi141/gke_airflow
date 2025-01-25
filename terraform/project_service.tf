locals {
  project_services = [
    "servicenetworking.googleapis.com"
  ]
}


resource "google_project_service" "services" {
  for_each = toset(local.project_services)
  project  = data.google_project.project.project_id
  service  = each.key
}
