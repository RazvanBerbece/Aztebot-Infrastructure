provider "google" {
  credentials = file("keys/sa.json")

  project = "aztebot-403621"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}

provider "google-beta" {
  credentials = file("keys/sa.json")
  project     = "aztebot-403621"
}