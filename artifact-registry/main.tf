resource "google_artifact_registry_repository" "aztebot-docker-repo" {
  location      = var.ar_location
  repository_id = var.ar_id
  description   = var.ar_description
  format        = "DOCKER"
}

# Allow IAM Members to read & upload artifacts to AR
resource "google_artifact_registry_repository_iam_binding" "binding" {
  project = google_artifact_registry_repository.aztebot-docker-repo.project
  location = google_artifact_registry_repository.aztebot-docker-repo.location
  repository = google_artifact_registry_repository.aztebot-docker-repo.name
  role = "roles/artifactregistry.admin"
  members = [
    "serviceAccount:${var.ar_service_account_email}",
  ]
}