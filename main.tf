terraform {
 required_providers {
 azurerm = {
 source = "hashicorp/azurerm"
 version = "~> 3.0"
 }
 }
 required_version = ">= 1.0"
}

provider "azurerm" {
 features {}
}
# Resource Group
resource "azurerm_resource_group" "ha_rg" {
 name = var.resource_group_name
 location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "ha_vnet" {
 name = "ha-vnet"
 address_space = ["10.0.0.0/16"]
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name
}
# Web Subnet
resource "azurerm_subnet" "web_subnet" {
 name = "web-subnet"
 resource_group_name = azurerm_resource_group.ha_rg.name
 virtual_network_name = azurerm_virtual_network.ha_vnet.name
 address_prefixes = ["10.0.1.0/24"]
}

# Database Subnet
resource "azurerm_subnet" "db_subnet" {
 name = "db-subnet"
 resource_group_name = azurerm_resource_group.ha_rg.name
 virtual_network_name = azurerm_virtual_network.ha_vnet.name
 address_prefixes = ["10.0.2.0/24"]
}
# Web NSG
resource "azurerm_network_security_group" "web_nsg" {
 name = "web-nsg"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name

 security_rule {
 name = "Allow-HTTP"
 priority = 100
 direction = "Inbound"
 access = "Allow"
 protocol = "Tcp"
 source_port_range = "*"
 destination_port_range = "80"
 source_address_prefix = "*"
 destination_address_prefix = "*"
 }
}

# DB NSG
resource "azurerm_network_security_group" "db_nsg" {
 name = "db-nsg"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name

 security_rule {
 name = "Allow-SQL"
 priority = 100
 direction = "Inbound"
 access = "Allow"
 protocol = "Tcp"
 source_port_range = "*"
 destination_port_range = "1433"
 source_address_prefix = "10.0.1.0/24"
 destination_address_prefix = "*"
 }
}

# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_pip" {
 name = "lb-public-ip"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name
 allocation_method = "Static"
 sku = "Standard"
}

# Load Balancer
resource "azurerm_lb" "ha_lb" {
 name = "ha-load-balancer"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name
 sku = "Standard"

 frontend_ip_configuration {
 name = "frontend-ip"
 public_ip_address_id = azurerm_public_ip.lb_pip.id
 }
}

# Backend Address Pool
resource "azurerm_lb_backend_address_pool" "lb_backend" {
 loadbalancer_id = azurerm_lb.ha_lb.id
 name = "ha-backend-pool"
}

# Health Probe
resource "azurerm_lb_probe" "lb_probe" {
 loadbalancer_id = azurerm_lb.ha_lb.id
 name = "http-health-probe"
 protocol = "Http"
 port = 80
 request_path = "/"
}

# Load Balancer Rule
resource "azurerm_lb_rule" "lb_rule" {
 loadbalancer_id = azurerm_lb.ha_lb.id
 name = "http-rule"
 protocol = "Tcp"
 frontend_port = 80
 backend_port = 80
 frontend_ip_configuration_name = "frontend-ip"
 backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend.id]
 probe_id = azurerm_lb_probe.lb_probe.id
}

# Network Interface - VM1
resource "azurerm_network_interface" "vm1_nic" {
 name = "vm1-nic"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name

 ip_configuration {
 name = "vm1-ip-config"
 subnet_id = azurerm_subnet.web_subnet.id
 private_ip_address_allocation = "Dynamic"
 }
}

# Network Interface - VM2
resource "azurerm_network_interface" "vm2_nic" {
 name = "vm2-nic"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name

 ip_configuration {
 name = "vm2-ip-config"
 subnet_id = azurerm_subnet.web_subnet.id
 private_ip_address_allocation = "Dynamic"
 }
}

# Web VM1
resource "azurerm_linux_virtual_machine" "web_vm1" {
 name = "web-vm1"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name
 size = "Standard_D2s_v3"
 admin_username = "azureuser"
 network_interface_ids = [azurerm_network_interface.vm1_nic.id]

 admin_ssh_key {
 username = "azureuser"
 public_key = file("~/.ssh/id_rsa.pub")
 }

 os_disk {
 caching = "ReadWrite"
 storage_account_type = "Standard_LRS"
 }

 source_image_reference {
 publisher = "Canonical"
 offer = "UbuntuServer"
 sku = "18.04-LTS"
 version = "latest"
 }
}

# Web VM2
resource "azurerm_linux_virtual_machine" "web_vm2" {
 name = "web-vm2"
 location = azurerm_resource_group.ha_rg.location
 resource_group_name = azurerm_resource_group.ha_rg.name
 size = "Standard_D2s_v3"
 admin_username = "azureuser"
 network_interface_ids = [azurerm_network_interface.vm2_nic.id]

 admin_ssh_key {
 username = "azureuser"
 public_key = file("~/.ssh/id_rsa.pub")
 }

 os_disk {
 caching = "ReadWrite"
 storage_account_type = "Standard_LRS"
 }

 source_image_reference {
 publisher = "Canonical"
 offer = "UbuntuServer"
 sku = "18.04-LTS"
 version = "latest"
 }
}
