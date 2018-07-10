resource "azurerm_network_security_group" "secure" {
    name                = "AZMAGSGKAFUAT"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.machine.name}"

    security_rule {
      name                       = "ssh_access"
      access                     = "Allow"
      direction                  = "Inbound"
      priority                   = "100"
      protocol                   = "TCP"
      destination_port_ranges    = ["22", "8000-8030"]
      destination_address_prefix = "*"
      source_port_range          = "*"
      source_address_prefix      = "${var.source_ip_prefix}"
    }
}
