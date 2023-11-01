provider "google" {
  credentials = file("keys/gcloud_service_account.json")

  project = "aztebot-403621"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}