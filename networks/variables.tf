variable "aztebot_subnet_cidr_range" {
  description = "CIDR range for the main subnetwork"
  type        = string
}

variable "aztebot_subnet_region" {
  description = "Region for the main subnetwork"
  type        = string
}

variable "aztebot_subnet_container_cidr_range" {
  description = "CIDR range for the container subnetwork"
  type        = string
}

variable "aztebot_subnet_service_cidr_range" {
  description = "CIDR range for the service subnetwork"
  type        = string
}