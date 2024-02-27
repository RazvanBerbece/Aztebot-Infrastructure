resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.cluster_location_zone
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc
  subnetwork = var.aztebot_subnet

  ip_allocation_policy {
    cluster_secondary_range_name  = var.aztebot_subnet_container_secondary_cidr_range_name
    services_secondary_range_name = var.aztebot_subnet_services_secondary_cidr_range_name
  }

  release_channel {
    channel = "STABLE"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_pool_name
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_min_count

  node_config {
    preemptible  = true
    machine_type = var.node_pool_machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.node_pool_service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # autoscaling {
  #   min_node_count = var.node_min_count
  #   max_node_count = var.node_max_count
  # }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  network_config {
    create_pod_range = false
    pod_range        = var.aztebot_subnet_container_secondary_cidr_range_name
  }
}