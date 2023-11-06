output "vpc_name" {
  description = "The name of the Virtual Private Cloud (VPC) created in Google Cloud"
  value       = google_compute_network.vpc.name
}

output "vpc_id" {
  description = "The ID of the Virtual Private Cloud (VPC) created in Google Cloud"
  value       = google_compute_network.vpc.id
}

output "aztebot_subnet_name" {
  description = "The name of the subnet within the specified VPC created in Google Cloud"
  value       = google_compute_subnetwork.aztebot-subnet.name
}

output "aztebot_subnet_container_secondary_cidr_range_name" {
  description = "The name of the secondary IP range used for cluster-level IP addresses within the specified subnet"
  value       = google_compute_subnetwork.aztebot-subnet.secondary_ip_range.0.range_name
}

output "aztebot_subnet_services_secondary_cidr_range_name" {
  description = "The name of the secondary IP range used for service-level IP addresses within the specified subnet"
  value       = google_compute_subnetwork.aztebot-subnet.secondary_ip_range.1.range_name
}