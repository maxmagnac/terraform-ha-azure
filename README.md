# Terraform High Availability Web Infrastructure on Azure

Author: Maurrin Carter  
Region: East US  
Repository: [github.com/maxmagnac/terraform-ha-azure](https://github.com/maxmagnac/terraform-ha-azure)

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
