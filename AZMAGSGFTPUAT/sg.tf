resource "azurerm_network_security_group" "puat-sg" {
    name = "AZMAGSGFTPUAT"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.machine.name}"

    security_rule {
      name                   = "AllowRDP"
      access                 = "Allow"
      direction              = "Inbound"
      priority               = "100"
      protocol               = "TCP"
      destination_port_range = "21, 5000-5050"
      source_port_range      = "*"
      source_address_prefix  = "${var.source_ip_prefix}"
    }
}
