provider "azurerm" {
    subscription_id     = "${var.subscription_id}"
}

resource "azurerm_resource_group" "blob" {
    name                = "${var.azurerm_resource_group_name}"
    location            = "${var.location}"
}

resource "azurerm_virtual_network" "blobvnet" {
    name                = "${var.virtual_network_name}"
    address_space       = ["${var.vnet_cidr}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.blob.name}"
}

resource "azurerm_subnet" "blobsub1" {
    name                 = "${var.subnet_name}"
    resource_group_name  = "${azurerm_resource_group.blob.name}"
    virtual_network_name = "${azurerm_virtual_network.blobvnet.name}"
    address_prefix       = "${var.address_prefix}"
    service_endpoints    = ["Microsoft.Sql","Microsoft.Storage"]
}

resource "azurerm_storage_account" "magblob" {
    name                     = "${var.storage_account_name}"
    resource_group_name      = "${azurerm_resource_group.blob.name}"
    location                 = "${var.location}"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    account_kind             = "BlobStorage"

    network_rules {
      ip_rules               = ["${var.my_ip}"]
    }
}

resource "azurerm_storage_container" "tfstate" {
    name                  = "${var.container_name}"
    resource_group_name   = "${azurerm_resource_group.blob.name}"
    storage_account_name  = "${azurerm_storage_account.magblob.name}"
    container_access_type = "private"
}
