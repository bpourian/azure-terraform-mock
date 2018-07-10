#AzureRM
variable "subscription_id" {}

variable "azurerm_resource_group_name_machine" {}
variable "azurerm_resource_group_name_vnet" {}
variable "virtual_network_name" {}

variable "location" {}
variable "vnet_cidr" {}
variable "subnet_name" {}
variable "subnet1_cidr" {}
variable "network_interface_name" {}
variable "public_ip_name" {}
variable "virtual_machine_name" {}

variable "source_ip_prefix" {}

variable "admin_username" {}
variable "admin_password" {}
