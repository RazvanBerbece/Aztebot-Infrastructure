provider "google" {
  credentials = file("keys/aztebot-403621-15e70c5e43f9.json")

  project = "aztebot-403621"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}