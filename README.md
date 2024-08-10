**Google Cloud Setup** A summary of the tasks involved to access the Memorystore redis cluster from the GCE VM in a shared VPC using the service connection policy with the PSC [ private service connect ]


**Supported Document**: 

A. https://cloud.google.com/memorystore/docs/cluster/instance-provisioning-shared-vpc

B. https://cloud.google.com/memorystore/docs/cluster/create-instance-terraform

C. https://cloud.google.com/memorystore/docs/cluster/connect-cluster-instance


1. Uses an existing Google Cloud project as a Consumer Project.
   a. In case of XPN[ Shared VPC], it could be a combination of existing **Host/Service** project.
   
2. Creates Consumer VPCs (or uses existing).

3. Creates subnets in Consumer VPCs (or uses existing).

4. Creates a **Service Connection Policy** for Memorystore for Redis Cluster in the VPC project. In case of XPN[ Shared VPC] , this is **Host** project.
    a. Policy determines where PSC endpoint is created
   
5. Creates a **Memorystore for Redis cluster** resource in a consumer Service project. In case of XPN[ Shared VPC] , this is **Service** project.
    a. Service instance for MRC stays in a producer project (LB, VMs)/ Tenant Project.
   
6. Create a **GCE instance** in Consumer project to be able to connect to the MRC (service instance).In case of XPN[ Shared VPC] , this is **Service** project.
    
7. Create **firewall rules** to allow traffic between consumer GCE instance and MRC (service instance). In case of XPN[ Shared VPC] , this is **Host** project.
    
8. Deploy **NAT** in the VPC project. In case of XPN[ Shared VPC] , this is **Host** project.

9. **SSH** into the GCE VM and telnet to MRC discovery Endpoint and Port.


**NOTE**: Following APIs needs to be enabled;

1. **HOST** Project:

- Compute Engine API
- Network Connectivity API

2. **Service** Project:

- Compute Engine API
- Network Connectivity API
- Redis API
- Service Consumer API

