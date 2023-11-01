variable "instance_name" {
  description = "Name for the compute instance"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to attach the instance"
  type        = string
}

variable "machine_type" {
  description = "Google Cloud VM machine type in the right format"
  type        = string
}

variable "machine_zone" {
  description = "Google Cloud VM machine zone in the right format"
  type        = string
}

variable "machine_image" {
  description = "Google Cloud VM machine image in the right format"
  type        = string
}

variable "account_username" {
  description = "Google Cloud Account username"
  type        = string
}