data "google_compute_network" "vpc" {
  project = var.project_id
  name    = var.vpc
}