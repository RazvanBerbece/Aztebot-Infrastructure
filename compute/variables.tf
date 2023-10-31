variable "instance_name" {
  description = "Name for the compute instance"
  type        = string
}

variable "subnetwork_id" {
  description = "ID of the subnetwork to attach the instance"
  type        = string
}