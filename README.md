# Terraform Script for VM to Memorystore Redis Cluster Lab

This Terraform script streamlines the setup of a lab environment where you can access a Memorystore Redis Cluster residing in a service project from a VM within the same service project. The setup leverages a Shared VPC in the host project and utilizes Service Connection Policies with Private Service Connect (PSC).

## Supported Documentation

* [Service connection policy for Memroystore Redis Cluster in the Shared VPC](https://cloud.google.com/memorystore/docs/cluster/instance-provisioning-shared-vpc#create_a_service_connection_policy)
* [Creating a Memorystore Redis instance](https://cloud.google.com/memorystore/docs/cluster/create-instance-terraform)
* [Connecting to a Memorystore Redis instance](https://cloud.google.com/memorystore/docs/cluster/connect-cluster-instance)

## Prerequisites

* Basic understanding of Terraform
* General experience with Google Cloud Platform (GCP)
* Existing Host project and Service project in GCP
* A service account or your own account with the necessary permissions to create the required resources (see below)

## Required IAM Permissions

You can assign the following pre-existing IAM roles to your service account or personal account to perform the necessary operations:

* **Host Project**
    * `roles/compute.networkAdmin`
    * `roles/networkconnectivity.admin`
* **Service Project**
    * `roles/compute.networkAdmin`
    * `roles/redis.admin`
    * `roles/serviceusage.serviceUsageAdmin`

You can further refine the access by creating a custom role and only assign the required permissions.

## Resources Created

This Terraform script will create the following resources:

1. **Shared VPC** in the Host project.
2. A **Subnet** within the Shared VPC.
3. A **Service Connection Policy** for Memorystore Redis Cluster in the Host project.
4. A **Memorystore Redis Cluster** in the Service project.
5. A **GCE instance** in the Service project to connect to the Redis cluster.
6. A **Firewall rule** in the Host project to allow traffic between the GCE instance and the Redis cluster.
7. A **NAT** gateway in the Host project.

## Getting Started

1. **Fork/Clone** the forked repository to your local machine.
2. **Authenticate** with `gcloud auth login` (if using your personal account).
3. **Initialize Terraform:** Run `terraform init`.
4. **Create `terraform.tfvars`:**
    * Copy the `terraform.tfvars.example` file to `terraform.tfvars`.
    * Fill in the required values in your `terraform.tfvars` file.
5. **Plan:** Run `terraform plan` to preview the changes.
6. **Apply:** Run `terraform apply` to create the infrastructure.

## Connecting to the Redis Cluster

### Using Telnet

1. Get the Redis cluster's IP and port from `terraform.tfstate`, or the Cloud Console.
2. SSH into the GCE VM.
3. Run the [telnet command](https://cloud.google.com/memorystore/docs/cluster/connect-cluster-instance) to test connectivity. It should look like `telnet <mrc_ip> <mrc_port>` (e.g., `telnet 10.0.0.5 6379`).
4. In the telnet shell, test with `ping` (server should respond with `pong`).
5. Use `SET "key" "value"` and `GET "key"` to interact with the Redis cluster.

**Note:** You might encounter `MOVED` errors. These indicate redirection to a different shard/port. Use the new port in the `MOVED` message to reconnect(Eg error: `MOVED 2058 10.0.0.4:11002` , update telnet like: `telnet 10.0.0.4 11002`)

### Using redis-cli

1. SSH into the GCE VM.
2. Use [redis-cli utility](https://cloud.google.com/memorystore/docs/cluster/connect-cluster-instance#connect_from_a_compute_engine_vm_using_redis_cli) like `redis-cli -h <host_ipv4> -p <port> -c` to connect in cluster mode.
3. Use `SET "key" "value"` and `GET "key"` to interact with the Redis cluster.

**NOTE:** The `-c` switch is crucial for cluster support, preventing `MOVED` errors when accessing keys on different shards. 

## Cleanup

Run `terraform destroy` to delete all the created resources.

**Important:** Ensure you understand the implications before running `terraform destroy` in a production environment.