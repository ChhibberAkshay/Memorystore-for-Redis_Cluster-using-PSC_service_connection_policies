project_id         = "akshayhostproject"
service_project_id = "akshayserviceproject"
host_network       = "akshayhostnetwork"
my_subnets = [
  {
    ip_cidr_range = "10.0.0.0/24"
    name          = "akshayhostnetworksubnet"
    region        = "us-central1"
  }
]
vm_name       = "akshaynewredisconnect"
zone          = "us-central1-a"
region        = "us-central1"
service_name  = "service-connection-policy"
location      = "us-central1"
service_class = "gcp-memorystore-redis"
redis_cluster = "akshayredis"
router_name   = "netflix"