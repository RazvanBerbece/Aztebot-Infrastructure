module "auth" {
  source                          = "./auth"
  project_id                      = "aztebot-403621"
  ci_service_account_display_name = "Service Account - github-svc"
}

module "networks" {
  source        = "./networks"
  network_name  = "aztebot-network"
  subnet_name   = "aztebot-subnet"
  subnet_region = "europe-west2"
}

module "compute" {
  source           = "./compute"
  instance_name    = "aztebot-vm"
  subnet_id        = module.networks.subnet_id
  machine_type     = "f1-micro"
  machine_zone     = "europe-west2-c"
  machine_image    = "debian-cloud/debian-11"
  account_username = "antonio99.dev"
}

module "firewall" {
  source        = "./firewall"
  firewall_name = "aztebot-vm-allow-ssh"
  network_name  = module.networks.network_name
}

module "artifact-registry" {
  source         = "./artifact-registry"
  ar_location    = "europe-west2"
  ar_id          = "aztebot-docker-ar"
  ar_description = "Docker container registry for the Aztebot service"
}
