data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.10.0.0"
  prefix_length = 16
  network       = data.google_compute_network.default.id
}

resource "google_service_networking_connection" "default" {
  network                 = data.google_compute_network.default.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
