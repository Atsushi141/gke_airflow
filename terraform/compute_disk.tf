# resource "google_compute_disk" "airflow_dags_disk" {
#   name                      = "airflow-dags-disk"
#   type                      = "pd-standard"
#   zone                      = local.zone
#   physical_block_size_bytes = 16384 # 16GiB
# }
