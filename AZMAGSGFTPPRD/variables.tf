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
  description = "AZMAGRGFTPPRD"
}

variable "location" {
  description = "UK West"
}
