output "jenkins_master_internal_ip" {
  value = google_compute_instance.jenkins_master_vm.network_interface.0.network_ip
}

output "jenkins_master_external_ip" {
  description = "External IP address of the instance"
  value       = google_compute_instance.jenkins_master_vm.network_interface[0].access_config[0].nat_ip
}

output "sql_instance_external_ip" {
  value = google_sql_database_instance.postgres_instance.public_ip_address
}