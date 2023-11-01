resource "google_artifact_registry_repository" "aztebot-docker-repo" {
  location      = var.ar_location
  repository_id = var.ar_id
  description   = var.ar_description
  format        = "DOCKER"
}