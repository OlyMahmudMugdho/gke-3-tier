
resource "google_compute_instance" "jenkins_master_vm" {
  name         = "my-instance"
  machine_type = "e2-standard-4"
  zone         = var.zone

  tags = var.jenkins_master_tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      type  = "pd-balanced"
      size  = 50
    }
  }

  network_interface {
    network    = google_compute_network.workloads_network.id
    subnetwork = google_compute_subnetwork.pipeline_workloads_subnet.id

    access_config {
      // Ephemeral public IP
    }

  }

}
