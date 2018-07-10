###############################################################################
# Developed by Benjamin Pourian @MagenTys
# Free distribution, free usage
# Demo purposee only
###############################################################################

data "terraform_remote_state" "remotestate" {
  backend = "azurerm"
  config {
    storage_account_name = "${var.storage_account_name}"
    container_name       = "${var.container_name}"
    key                  = "${var.storage_key}"
    access_key           = "${var.access_key}"
  }
}

provider "azurerm" {
  subscription_id = "${data.terraform_remote_state.remotestate.subscription_id}"
}

resource "azurerm_resource_group" "machine" {
    name     = "${var.azurerm_resource_group_name_machine}"
    location = "${var.location}"
}

resource "azurerm_subnet" "vnetsub12" {
    name                 = "AZMAGSNET12"
    address_prefix       = "${var.subnet1_cidr}"
    resource_group_name  = "${data.terraform_remote_state.remotestate.azurerm_resource_group_name_vnet}"
    virtual_network_name = "${data.terraform_remote_state.remotestate.virtual_network_name}"
}

resource "azurerm_public_ip" "pprd-ip" {
    name                         = "${var.public_ip_name}"
    location                     = "${var.location}"
    public_ip_address_allocation = "static"
    resource_group_name          = "${azurerm_resource_group.machine.name}"
}

resource "azurerm_network_interface" "net-i" {
    name                      = "AZMAGNIC12"
    location                  = "${var.location}"
    resource_group_name       = "${data.terraform_remote_state.remotestate.azurerm_resource_group_name_vnet}"
    network_security_group_id = "${azurerm_network_security_group.pprd-sg.id}"

    ip_configuration {
    name                          = "AZBENVNIP2-private"
    subnet_id                     = "${azurerm_subnet.vnetsub12.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.1.4"
    public_ip_address_id          = "${azurerm_public_ip.pprd-ip.id}"
  }
}

resource "azurerm_virtual_machine" "vmmachine" {
  name                  = "AZMAGRGFTPPRD"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.machine.name}"
  network_interface_ids = ["${azurerm_network_interface.net-i.id}"]
  vm_size               = "Standard_DS2_v2"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${azurerm_resource_group.machine.name}-OSdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "Windows2016-ssh"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_windows_config {
  }
}
