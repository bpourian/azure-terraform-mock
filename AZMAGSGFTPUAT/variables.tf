#AzureRM
variable "subscription_id" {
  description = "azure subscription id"
  default     = "${var.subscription_id}"
}

variable "tenant_id" {
  description = "Directory ID "
  default     = "${var.tenant_id}"
}

variable "azurerm_resource_group" {
  description = "Name of resource group"
  default     = "AZMAGRGFTPUAT"
}

variable "location" {
  description = "Location of resource group"
  default     = "ukwest"
}

variable "azurerm_virtual_network" {
  default = "AZMAGRGVNET1"
}

variable "azurerm_subnet" {
  default = "AZMAGSNET11"
}

variable "admin_username" {
  default = "${var.vm_username}"
}

variable "admin_password" {
  default = "${var.vm_password}"
}
