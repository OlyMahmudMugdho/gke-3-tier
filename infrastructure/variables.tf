variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-c"
}

variable "vpc_name" {
  type    = string
  default = "workloads-network"
}

variable "kubernetes_workloads_subnet_name" {
  type    = string
  default = "kubernetes-workloads"
}

variable "pipeline_workloads_subnet_name" {
  type    = string
  default = "pipeline-workloads"
}

variable "auto_create_subnetworks_value" {
  type    = bool
  default = false
}

variable "jenkins_master_rule_name" {
  type    = string
  default = "jenkins-master-rule"
}

variable "jenkins_master_tags" {
  type    = set(string)
  default = ["jenkins-master"]
}

variable "jenkins_master_rule_ranges" {
  type    = set(string)
  default = ["0.0.0.0/0"]
}

variable "jenkins_master_vm_name" {
  type    = string
  default = "jenkins-master"
}


variable "gke_node_machine_type" {
  type    = string
  default = "e2-standard-4"
}

variable "jenkins_master_machine_type" {
  type    = string
  default = "e2-standard-4"
}

variable "jenkins_agent_machine_type" {
  type    = string
  default = "e2-standard-4"
}


variable "jenkins_agent_vm_name" {
  type    = string
  default = "e2-standard-4"
}

variable "jenkins_agent_tags" {
  type    = set(string)
  default = ["jenkins-agent"]
}

variable "jenkins_agent_rule_ssh_source" {
  type    = set(string)
  default = ["0.0.0.0/0"]
}


variable "jenkins_agent_rule_name" {
  type    = string
  default = "jenkins-agent-rule"
}
