provider "google" {
  project = "aztebot-403621"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}

provider "google-beta" {
  project     = "aztebot-403621"
}