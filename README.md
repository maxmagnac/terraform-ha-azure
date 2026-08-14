# Terraform High Availability Web Infrastructure on Azure

Author: Maurrin Carter
Region: East US
Repository: [github.com/maxmagnac/terraform-ha-azure](https://github.com/maxmagnac/terraform-ha-azure "source-reference")

## Project Description

This project automates the deployment of a high availability web infrastructure on Microsoft Azure using Terraform. It mirrors a production-grade architecture with redundancy and security controls.

## Architecture Overview

- Runs across two availability zones in East US
- Public-facing load balancer distributes traffic across two Linux web servers
- Dedicated network security group protects the database subnet

## Infrastructure Components

| Component | Description |
|---|---|
| Resource Group | Logical container for all resources |
| Virtual Network | Network segmentation and isolation |
| Subnets | Web and database subnet separation |
| Load Balancer | Public traffic distribution |
| Virtual Machines | Two Linux web servers |
| Network Security Groups | Traffic filtering rules |

## Technologies Used

- Terraform - Infrastructure as Code
- Microsoft Azure - Cloud Platform
- Azure Virtual Machines - Linux web servers (`Standard_D2s_v3`)
- Azure Load Balancer - Traffic distribution
- Azure Virtual Network - Network segmentation
- Network Security Groups - Traffic filtering
- Azure CLI - Authentication and management
- GitHub - Version control and portfolio

## Prerequisites

- Terraform (version 1.0+)
- Azure CLI
- Active Azure subscription

## Deployment Instructions

Clone the repository:

```bash
git clone [https://github.com/maxmagnac/terraform-ha-azure.git](https://github.com/maxmagnac/terraform-ha-azure.git)

Screenshots
Resource Group
<img width="1422" height="567" alt="terraform_haweb_resource_group" src="https://github.com/user-attachments/assets/533a6335-4bc0-4d9d-a203-bf3df6940d00" />
Virtual Network
<img width="1606" height="432" alt="terraform_haweb_vnet" src="https://github.com/user-attachments/assets/b28a3b85-d340-4a1e-9fc8-e946ef75b04b" />
Load Balancer
<img width="1539" height="362" alt="ha-load-balancer" src="https://github.com/user-attachments/assets/0b81f41b-a97f-4ffe-b7c8-c6b9f7fdfce2" />
Virtual Machines
<img width="1465" height="553" alt="terraform_haweb_vm1andvm2" src="https://github.com/user-attachments/assets/a11f12b7-1cce-47ea-aedc-1079b331e323" />
Network Security Groups
<img width="1336" height="429" alt="terraform_haweb_web_nsganddb_nsg" src="https://github.com/user-attachments/assets/ae6c1e30-244e-42d5-8cdd-774463e4f5cf" />
GitHub Repository
<img width="1175" height="545" alt="terraform_haweb_github_repo" src="https://github.com/user-attachments/assets/ab180432-165d-468a-aefa-83b991dfc9e2" />
Terraform Apply Output
