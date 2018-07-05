###############################################################################
# Developed by Benjamin Pourian @MagenTys
# Free distribution, free usage
# Demo purposee only
###############################################################################

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "AZMAGRGFTPPRD" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "AZMAGRGVNET1" {
  name                = "${var.azurerm_virtual_network}"
  resource_group_name = "AZMAGRGVNET1"
}

resource "azurerm_subnet" "AZMAGSNET11" {
  name                 = "${var.azurerm_subnet}"
  virtual_network_name = "${var.azurerm_virtual_network}"
}
