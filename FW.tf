module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "9.1.0"
  project_id   = var.project_id
  network_name = module.vpc-host.name

  ingress_rules = [{
    name                    = "allow-memorystore-connect"
    description             = null
    direction               = "INGRESS"
    priority                = null
    source_ranges           = ["10.0.0.0/24"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["6379"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
    }

  ]
}