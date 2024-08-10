# Create a service connection policy
resource "google_network_connectivity_service_connection_policy" "default" {
  network       = module.vpc-host.self_link
  location      = var.location
  service_class = var.service_class
  name          = var.service_name
  project       = var.project_id
  psc_config {
    subnetworks = ["projects/${var.project_id}/regions/${var.region}/subnetworks/${var.my_subnets[0].name}"]
    limit       = 16
  }
}