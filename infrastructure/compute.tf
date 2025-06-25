
resource "google_compute_instance" "jenkins_master_vm" {
  name         = var.jenkins_master_vm_name
  machine_type = var.jenkins_master_machine_type
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

resource "google_compute_instance" "jenkins_agent_vm" {
  name         = var.jenkins_agent_vm_name
  machine_type = var.jenkins_agent_machine_type
  zone         = var.zone

  tags = var.jenkins_agent_tags

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
  }

}
