terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "cluster_name" {
  default = "gke-autopilot-cluster"
}

resource "google_container_cluster" "primary" {
  name             = var.cluster_name
  location         = var.region
  enable_autopilot = true
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}
