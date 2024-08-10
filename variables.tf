variable "project_id" {
  description = "host project being used for sharing vpc."
  type        = string
}

variable "service_project_id" {
  description = "Project to be used for resources deployment in gcp."
  type        = string
}

variable "host_network" {
  description = "Network to be used for vm instance/redis cluster deployment in gcp in host project"
  type        = string
}

variable "my_subnets" {

  type = list(object({
    ip_cidr_range = string
    name          = string
    region        = string
  }))

  description = "list of subnets to be deployed"
  default     = []
}

variable "region" {
  description = "region to be used for resources deployment in gcp."
  type        = string
}

variable "zone" {
  description = "zone to be used for redis instance deployment in gcp."
  type        = string
}

variable "vm_name" {
  type        = string
  description = "Name of the vm instance which connects to redis cluster"
}

variable "psc_config" {
  type = list(object({
    subnetworks = list(string)
    limit       = number
  }))
  description = "List of PSC configurations (subnetworks and limits)"
  default     = []
}

variable "service_name" {
  type        = string
  description = "Name of the service connection policy"
}

variable "location" {
  type        = string
  description = "Location of the service connection policy"
}

variable "service_class" {
  type        = string
  description = "Service class of the policy (e.g., 'gcp-memorystore-redis')"
}

variable "redis_cluster" {
  description = "redis cluster to be deployed."
  type        = string
}

variable "router_name" {
  type        = string
  description = "Name of the cloud router"
}