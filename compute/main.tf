resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.machine_zone
  tags         = ["ssh", "http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = var.machine_image
    }
  }

  # Install any dependencies required by the services (e.g.: Docker, MySQL, Go SDK?) 
  # TODO: Move this value in separate file
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential; sudo apt-get install docker.io; echo \"deb https://packages.cloud.google.com/apt cloud-sdk main\" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list; curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.asc; sudo apt-get update && sudo apt-get install google-cloud-cli"

  metadata = {
    ssh-keys = "${var.account_username}:${file("~/.ssh/id_rsa.pub")}"
  }

  network_interface {
    subnetwork = var.subnet_id
    access_config {}
  }

}