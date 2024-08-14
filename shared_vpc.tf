module "vpc-host" {
  source          = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc"
  project_id      = var.project_id
  name            = var.host_network
  subnets         = var.my_subnets
  shared_vpc_host = true
  shared_vpc_service_projects = [
    var.service_project_id
  ]
}