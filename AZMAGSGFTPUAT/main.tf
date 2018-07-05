###############################################################################
# Developed by Benjamin Pourian @MagenTys
# Free distribution, free usage
# Demo purposee only
###############################################################################

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "AZMAGRGFTPUAT" {
  name     = "${var.azurerm_resource_group}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "AZMAGVNET1" {
  name                = "AZMAGVNET1"
  resource_group_name = "AZMAGRGVNET1"
}

resource "azurerm_subnet" "AZMAGSNET11" {
  name                 = "${var.azurerm_subnet}"
  virtual_network_name = "${var.azurerm_virtual_network.AZMAGVNET1.name}"
}

resource "azurerm_virtual_machine" "AZMAGVMCFTPUAT" {
  name                  = "AZMAGSGFTPUAT"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group}"
  # network_interface_ids = ["${azurerm_network_interface.public_nic.id}"]
  vm_size               = "Standard_DS1_v2"

  #This will delete the OS disk and data disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.azurerm_resource_group}-OSdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "windows"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"

  }
}
