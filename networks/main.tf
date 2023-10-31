resource "google_compute_network" "aztebot_vpc_network" {
  name                    = "aztebot-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "aztebot_subnet" {
  name          = "aztebot-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west2"
  network       = google_compute_network.aztebot_vpc_network.id
}