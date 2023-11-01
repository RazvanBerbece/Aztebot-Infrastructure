output "network_id" {
  value = google_compute_network.aztebot_vpc_network.id
}

output "network_name" {
  value = google_compute_network.aztebot_vpc_network.name
}

output "subnet_id" {
  value = google_compute_subnetwork.aztebot_subnet.id
}