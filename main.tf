module "apis" {
  source = "./apis"
}

module "auth" {
  source = "./auth"

  project_id                      = "aztebot-403621"
  ci_service_account_display_name = "CD Service Account - cd-service-account"

  depends_on = [
    module.apis
  ]
}

module "aztebot_network" {
  source = "./networks"

  aztebot_subnet_cidr_range           = "10.105.0.0/24"
  aztebot_subnet_region               = "europe-west2"
  aztebot_subnet_container_cidr_range = "10.75.0.0/20"
  aztebot_subnet_service_cidr_range   = "10.8.0.0/14"

  depends_on = [
    module.apis
  ]
}

module "artifact-registry" {
  source = "./artifact-registry"

  ar_service_account_email = module.auth.cd_service_account_email
  ar_location              = "europe-west2"
  ar_id                    = "aztebot-docker-ar"
  ar_description           = "Docker container registry for the Aztebot service"

  depends_on = [
    module.auth
  ]
}

module "cloud_sql_instance" {
  source = "./cloud-sql"

  sql_database_instance_name = "aztebot-bot-sql-cloud-instance"
  sql_database_version       = "MYSQL_5_7"
  sql_database_region        = "europe-west2"
  sql_database_tier          = "db-f1-micro"
  private_network_id         = module.aztebot_network.vpc_id
  project_id                 = "aztebot-403621"
  db_manager_sa_email        = module.auth.sa_db_manager_email

  depends_on = [
    module.aztebot_network
  ]
}

module "gke_cluster" {
  source = "./gke"

  cluster_name                    = "aztebot-cluster"
  cluster_location_zone           = "europe-west2-c"
  node_pool_name                  = "aztebot-node-pool"
  node_min_count                  = 1
  node_max_count                  = 3
  node_pool_machine_type          = "e2-small"
  node_pool_service_account_email = module.auth.cd_service_account_email

  vpc                                                = module.aztebot_network.vpc_name
  aztebot_subnet                                     = module.aztebot_network.aztebot_subnet_name
  aztebot_subnet_container_secondary_cidr_range_name = module.aztebot_network.aztebot_subnet_container_secondary_cidr_range_name
  aztebot_subnet_services_secondary_cidr_range_name  = module.aztebot_network.aztebot_subnet_services_secondary_cidr_range_name

  depends_on = [
    module.auth
  ]
}

