module "auth" {
  source                          = "./auth"
  project_id                      = "aztebot-403621"
  ci_service_account_display_name = "Service Account - cd-service-account"
}

module "artifact-registry" {
  source                   = "./artifact-registry"
  ar_service_account_email = module.auth.cd_service_account_email
  ar_location              = "europe-west2"
  ar_id                    = "aztebot-docker-ar"
  ar_description           = "Docker container registry for the Aztebot service"

  depends_on = [
    module.auth
  ]
}

module "gke_cluster" {
  source                          = "./gke"
  cluster_name                    = "aztebot-cluster"
  cluster_location_zone           = "europe-west2-c"
  node_pool_name                  = "aztebot-node-pool"
  node_pool_count                 = 1
  node_pool_machine_type          = "e2-small"
  node_pool_service_account_email = module.auth.cd_service_account_email

  depends_on = [
    module.auth
  ]
}

