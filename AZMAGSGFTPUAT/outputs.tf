output "subscription_id" {
    sensitive = true
    value = "${var.subscription_id}"
}

output "vnet_cidr" {
    value = "${var.vnet_cidr}"
}

output "azurerm_resource_group_name_vnet" {
    value = "${var.azurerm_resource_group_name_vnet}"
}

output "virtual_network_name" {
    sensitive = true
    value     = "${var.virtual_network_name}"
}
