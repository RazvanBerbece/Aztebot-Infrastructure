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

variable "node_pool_count" {
  description = "Node count for the GKE cluster node pool"
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

