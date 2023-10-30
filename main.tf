terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("keys/aztebot-403621-15e70c5e43f9.json")

  project = "aztebot-403621"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}