#AzureRM
variable "subscription_id" {
  description = "azure subscription id"
  default     = "${var.subscription_id}"
}

variable "tenant_id" {
  description = "Directory ID "
  default     = "${var.tenant_id}"
}

variable "resource_group_name" {
  description = "Name of resource group"
  default     = "AZMAGRGFTPPRD"
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
