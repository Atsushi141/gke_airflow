variable "cloud_sql_password" {
  type    = string
  default = "hoge"
}

resource "google_sql_database_instance" "airflow" {
  name             = "airflow"
  region           = local.location
  database_version = "POSTGRES_16"

  settings {
    tier    = "db-custom-1-4096" # https://zenn.dev/monicle/articles/e03a329c021873
    edition = "ENTERPRISE"

    ip_configuration {
      private_network = data.google_compute_network.default.id
      ipv4_enabled    = false
    }
  }

  deletion_protection = false
}


resource "google_sql_user" "airflow" {
  name     = "admin"
  instance = google_sql_database_instance.airflow.name
  password = var.cloud_sql_password
}

resource "google_sql_database" "airflow" {
  name     = "airflow"
  instance = google_sql_database_instance.airflow.name
}
