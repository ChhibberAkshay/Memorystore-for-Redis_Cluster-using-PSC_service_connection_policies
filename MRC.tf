module "redis_cluster" {
  source  = "terraform-google-modules/memorystore/google//modules/redis-cluster"
  version = "~> 10.0"

  name      = var.redis_cluster
  project   = var.service_project_id
  region    = var.region
  network   = ["projects/${var.project_id}/global/networks/${var.host_network}"]
  node_type = "REDIS_STANDARD_SMALL"

  redis_configs = {
    maxmemory-policy = "volatile-ttl"
  }
 depends_on = [google_network_connectivity_service_connection_policy.default, module.vpc-host] # Add dependency on the service connection policy default resource as well as the shared vpc in the host project
}