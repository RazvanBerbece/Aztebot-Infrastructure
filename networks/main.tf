resource "google_compute_network" "aztebot_vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "aztebot_subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.1.0/24"
  region        = var.subnet_region
  network       = google_compute_network.aztebot_vpc_network.id
}