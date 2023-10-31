resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = "f1-micro"
  zone         = "europe-west2-c"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # Install any dependencies required by the services (e.g.: Docker, MySQL, Go SDK?)
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential"

  network_interface {
    subnetwork = var.subnetwork_id
  }

}