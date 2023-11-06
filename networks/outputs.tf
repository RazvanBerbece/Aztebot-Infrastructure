output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "aztebot_subnet_name" {
  value = google_compute_subnetwork.aztebot-subnet.name
}

output "aztebot_subnet_container_secondary_cidr_range_name" {
  value = google_compute_subnetwork.aztebot-subnet.secondary_ip_range.0.range_name
}

output "aztebot_subnet_services_secondary_cidr_range_name" {
  value = google_compute_subnetwork.aztebot-subnet.secondary_ip_range.1.range_name
}

