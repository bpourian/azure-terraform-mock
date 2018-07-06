###############################################################################
# Developed by Benjamin Pourian @MagenTys
# Free distribution, free usage
# Demo purposee only
###############################################################################

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
}

resource "azurerm_resource_group" "machine" {
    name     = "${var.azurerm_resource_group_name_machine}"
    location = "${var.location}"
}

resource "azurerm_resource_group" "vnetrm" {
    name     = "${var.azurerm_resource_group_name_vnet}"
    location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
    name                = "AZMAGVNET1"
    address_space       = ["${var.vnet_cidr}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.vnetrm.name}"
}

resource "azurerm_subnet" "vnetsub1" {
    name                 = "AZMAGSNET11"
    address_prefix       = "${var.subnet1_cidr}"
    resource_group_name  = "${azurerm_resource_group.vnetrm.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
}
