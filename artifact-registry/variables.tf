variable "ar_id" {
  description = "ID for the Artifact Registry"
  type        = string
}

variable "ar_description" {
  description = "Description for the Artifact Registry"
  type        = string
}

variable "ar_location" {
  description = "Google Cloud Artifact Registry location in the right format"
  type        = string
}

variable "ar_service_account_email" {
  description = "Google Cloud Artifact Registry service account email"
  type        = string
}