Terraform High Availability Web Infrastructure on Azure
Author: Maurrin Carter
Region: East US
Repository: github.com/maxmagnac/terraform-ha-azure

Project Description
This project uses Terraform to automate the deployment of a high availability web infrastructure on Microsoft Azure. The infrastructure mirrors a production-grade architecture with redundant virtual machines, a load balancer, tiered networking, and security controls - all provisioned through infrastructure as code.

Architecture Overview
The infrastructure runs across two availability zones in East US, with a public-facing load balancer distributing traffic across two Linux web servers. A separate database subnet sits behind a dedicated network security group, isolating backend resources from the web tier.

Infrastructure Components
Resource	Name
Resource Group	ha-web-rg
Virtual Network	ha-vnet
Web Subnet	web-subnet
Database Subnet	db-subnet
Network Security Group (Web)	web-nsg
Network Security Group (DB)	db-nsg
Load Balancer	ha-load-balancer
Virtual Machine 1	web-vm1
Virtual Machine 2	web-vm2
Screenshots
Resource Group
Virtual Network
Load Balancer
Virtual Machines
Network Security Groups
GitHub Repository
Terraform Apply Output
Prerequisites
Terraform installed (v1.0+)
Azure CLI installed and authenticated
Active Azure subscription
How to Deploy
Clone the repository:

git clone https://github.com/maxmagnac/terraform-ha-azure.git
cd terraform-ha-azure
Initialize Terraform:

terraform init
Preview the deployment:

terraform plan
Deploy the infrastructure:

terraform apply
Confirm with yes when prompted.

Technologies Used
Terraform - Infrastructure as Code
Microsoft Azure - Cloud Platform
Azure Virtual Machines - Linux web servers (Standard_D2s_v3)
Azure Load Balancer - Traffic distribution
Azure Virtual Network - Network segmentation
Network Security Groups - Traffic filtering
Azure CLI - Authentication and management
GitHub - Version control and portfolio
