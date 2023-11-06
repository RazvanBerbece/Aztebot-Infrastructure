resource "google_compute_network" "vpc" {
  name                    = "aztebot-vpc" // var.aztebot_network_name
  auto_create_subnetworks = false
}

# Subnet for cluster nodes
resource "google_compute_subnetwork" "aztebot-subnet" {
  name          = "${google_compute_network.vpc.name}-subnet"
  ip_cidr_range = var.aztebot_subnet_cidr_range
  region        = var.aztebot_subnet_region
  network       = google_compute_network.vpc.name

  secondary_ip_range {
    range_name    = "container-range-1"
    ip_cidr_range = var.aztebot_subnet_container_cidr_range
  }

  secondary_ip_range {
    range_name    = "service-range-1"
    ip_cidr_range = var.aztebot_subnet_service_cidr_range
  }
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${google_compute_network.vpc.name}-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
}