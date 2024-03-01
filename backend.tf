terraform {
  backend "gcs" {
    bucket = "bucket-tfstate-aztebot"
    prefix = "terraform/state"
  }
}