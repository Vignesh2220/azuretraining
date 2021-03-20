provider "azurerm" {
    version = "~> 2.0.0"
    features {}
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id

}

resource "azurerm_resource_group" "rg1" {
    name = var.resource_group
    location = var.location

}

resource "azurerm_storage_account" "satf" {
    name = "mystorageaccount2220"
    location = var.location
    resource_group_name = var.resource_group
    account_replication_type = "LRS"
    access_tier = "Standard"

    tags = {
        environment = "dev"
    }
} 

resource "azurerm_storage_container" "sactf" {
    name = "devsactf"
    storage_account_name = azurerm_storage_account.satf.name
}