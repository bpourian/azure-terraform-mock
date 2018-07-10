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
    name                = "${var.virtual_network_name}"
    address_space       = ["${var.vnet_cidr}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.vnetrm.name}"
}

resource "azurerm_subnet" "vnetsub1" {
    name                 = "${var.subnet_name}"
    address_prefix       = "${var.subnet1_cidr}"
    resource_group_name  = "${azurerm_resource_group.vnetrm.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
}

resource "azurerm_public_ip" "publicip" {
    name                         = "${var.public_ip_name}"
    location                     = "${var.location}"
    public_ip_address_allocation = "static"
    resource_group_name          = "${azurerm_resource_group.machine.name}"
}

resource "azurerm_network_interface" "neti" {
    name                      = "${var.network_interface_name}"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.vnetrm.name}"
    network_security_group_id = "${azurerm_network_security_group.secure.id}"

    ip_configuration {
    name                          = "AZBENVNIP1-private"
    subnet_id                     = "${azurerm_subnet.vnetsub1.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
  }
}

resource "azurerm_virtual_machine" "vmmachine" {
  name                  = "${var.virtual_machine_name}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.machine.name}"
  network_interface_ids = ["${azurerm_network_interface.neti.id}"]
  vm_size               = "Standard_DS2_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${azurerm_resource_group.machine.name}-OSdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "Ubuntu-ssh"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
