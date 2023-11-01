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

resource "google_compute_firewall" "egress" {

  name = "aztebot-vm-egress-rule"

  allow {
    ports    = ["80", "443"]
    protocol = "tcp"
  }

  direction     = "EGRESS"
  network       = var.network_name
  priority      = 1001
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http"]
}