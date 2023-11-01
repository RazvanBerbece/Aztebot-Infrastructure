resource "google_compute_firewall" "ssh" {

  name = var.firewall_name

  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = var.network_name
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}