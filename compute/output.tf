output "instance_id" {
  value = google_compute_instance.default.id
}

output "instance_internal_ip" {
  value = google_compute_instance.default.network_interface.0.network_ip
}

output "current_status" {
  value = google_compute_instance.default.current_status
}