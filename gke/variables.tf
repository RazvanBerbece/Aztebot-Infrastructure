variable "cluster_name" {
  description = "Name for the GKE cluster"
  type        = string
}

variable "cluster_location_zone" {
  description = "Location zone for the GKE cluster (e.g: europe-west2-c)"
  type        = string
}

variable "node_pool_name" {
  description = "Name for the GKE cluster node pool"
  type        = string
}

variable "node_pool_machine_type" {
  description = "Machine type for the GKE cluster pool nodes"
  type        = string
}

variable "node_pool_service_account_email" {
  description = "Service account to auth with the GKE cluster node pool"
  type        = string
}

variable "vpc" {
  description = "The name of the Virtual Private Cloud (VPC) in which the Google Container Cluster will be created. This VPC defines the networking environment for the cluster."
  type        = string
}

variable "aztebot_subnet" {
  description = "The name of the subnet within the specified VPC where the Google Container Cluster nodes will be deployed. Subnets define IP address ranges within a VPC."
  type        = string
}

variable "aztebot_subnet_container_secondary_cidr_range_name" {
  type = string
}

variable "aztebot_subnet_services_secondary_cidr_range_name" {
  type = string
}

variable "node_min_count" {
  type = number
}

variable "node_max_count" {
  type = number
}