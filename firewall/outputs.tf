output "ssh_firewall_id" {
  value = google_compute_firewall.ssh.id
}

output "egress" {
  value = google_compute_firewall.egress.id
}