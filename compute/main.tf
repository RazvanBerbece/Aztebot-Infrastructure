resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.machine_zone
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = var.machine_image
    }
  }

  # Install any dependencies required by the services (e.g.: Docker, MySQL, Go SDK?)
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential"

  network_interface {
    subnetwork = var.subnet_id
  }

}