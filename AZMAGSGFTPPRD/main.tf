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
