module "networks" {
  source       = "./networks"
  network_name = "aztebot-network"
}

module "compute" {
  source        = "./compute"
  instance_name = "aztebot-vm"
  subnetwork_id = module.networks.subnet_id
}

module "firewall" {
  source        = "./firewall"
  firewall_name = "allow-ssh"
  network_id    = module.networks.subnet_id
}
