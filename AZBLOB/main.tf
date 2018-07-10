provider "azurerm" {
  subscription_id = "${var.subscription_id}"
}

resource "azurerm_resource_group" "blob" {
    name     = "${var.azurerm_resource_group}"
    location = "${var.location}"
}

resource "azurerm_storage_account" "BLOBPUAT" {
    name                     = "azblobpuat"
    resource_group_name      = "${azurerm_resource_group.blob.name}"
    location                 = "${var.location}"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    account_kind             = "BlobStorage"
}

resource "azurerm" "" {

}
