# This is where I store the keys that will not be
# commited to a public repo
# Create a file called terraform.tfvars and complete
# each below as per your account and set-up needs

subscription_id    = "azure-id-goes-here"
admin_username     = "windows-machine-login-name"
admin_password     = "windows-machine-password"

azurerm_resource_group_name_machine = "AZURE-RESOURCE-GROUP-FOR-VM"
azurerm_resource_group_name_vnet    = "AZURE-RESOURCE-GROUP-FOR-VIRTUAL-NETWORK"

location         = "North Europe for example"
vnet_cidr        = "10.0.0.0/23"
subnet1_cidr     = "10.0.1.0/24"
public_ip_name   = "NAME-YOUR-IP"
source_ip_prefix = "SOURCE-IP-TO-WHITELIST"
