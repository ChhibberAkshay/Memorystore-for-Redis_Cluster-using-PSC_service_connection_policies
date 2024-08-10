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

}