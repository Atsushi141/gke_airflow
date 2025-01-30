# resource "random_string" "airflow_log_bucket_suffix" {
#   length  = 5
#   lower   = true
#   special = false
#   upper   = false
#   numeric = false
# }
#
# resource "google_storage_bucket" "airflow_log_bucket" {
#   name          = "airflow_log_bucket_${random_string.airflow_log_bucket_suffix.result}"
#   location      = local.location
#   force_destroy = true
# }
