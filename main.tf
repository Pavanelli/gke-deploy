provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50        # ou até 20 para teste
    disk_type    = "pd-standard"  # ou "pd-balanced", evita usar "pd-ssd"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 1
}
