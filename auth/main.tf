###### Auth is done via a Workload Identity Pool. 
###### The identity pool contains an identity pool *provider* which is issued by https://token.actions.githubusercontent.com in order to authorise connections.

###### RESOURCES TO ALLOW CD (CURRENTLY GH ACTIONS) TO CONNECT TO GCLOUD USING WIP
resource "google_service_account" "github-service-account" {
  project      = var.project_id
  account_id   = "gcp-github-access"
  display_name = var.ci_service_account_display_name
}

module "gh_oidc" {
  source            = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version           = "v3.1.1"
  project_id        = var.project_id
  pool_id           = "cd-identity-pool"
  pool_display_name = "CD Identity Pool"
  provider_id       = "cd-provider-aztebot"
  sa_mapping = {
    (google_service_account.github-service-account.account_id) = {
      sa_name   = google_service_account.github-service-account.name
      attribute = "*"
    }
  }
}

### IAM Bindings for CD
resource "google_service_account_iam_binding" "cd-account-iam" {
  service_account_id = google_service_account.github-service-account.name
  role               = "roles/owner" # TODO: Use least privilege here instead
  members = [
    "serviceAccount:${google_service_account.github-service-account.email}",
  ]
}
resource "google_project_iam_binding" "cd-gke-iam" {
  # This IAM binding is used for deploying the containers to AR from the app repository
  project = var.project_id
  role    = "roles/container.admin"
  members = [
    "serviceAccount:${google_service_account.github-service-account.email}",
  ]
}

###### RESOURCES TO ALLOW THE APP SERVICES TO CONNECT TO GCLOUD
resource "google_service_account" "database-manager-service-account" {
  project      = var.project_id
  account_id   = "sa-db-manager"
  display_name = "Service Account - Database Manager"
}
resource "google_project_iam_binding" "cloudsql-db-iam" {
  project = var.project_id
  role    = "roles/cloudsql.admin"
  members = [
    "serviceAccount:${google_service_account.database-manager-service-account.email}",
  ]
}