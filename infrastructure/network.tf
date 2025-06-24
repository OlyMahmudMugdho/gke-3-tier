resource "google_compute_network" "workloads_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks_value
}

resource "google_compute_subnetwork" "kubernetes_workloads_subnet" {
  name          = var.kubernetes_workloads_subnet_name
  ip_cidr_range = "10.1.0.0/16"
  region        = var.region
  network       = google_compute_network.workloads_network.id
}

resource "google_compute_subnetwork" "pipeline_workloads_subnet" {
  name          = var.pipeline_workloads_subnet_name
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.workloads_network.id
}


resource "google_compute_firewall" "jenkins_master_rule" {
  name    = var.jenkins_master_rule_name
  network = google_compute_network.workloads_network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8080", "22"]
  }

  source_ranges = var.jenkins_master_rule_ranges

  source_tags = var.jenkins_master_tags

  priority = 100
}
