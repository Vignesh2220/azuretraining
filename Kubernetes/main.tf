provider "azurerm" {
    version = "~> 2.0.0"
    features {}
}

resource "azurerm_resource_group" "rg1"{
    name = var.resource_group
    location = var.location
}

resource "azurerm_kubernetes_cluster" "kbtf" {
    name = "kbtfcluster1"
    location = var.location
    resource_group_name = azurerm_resource_group.rg1.name
    dns_prefix = "kbtfcluster1"

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            #key_data = file(var.ssh_public_key)
            key_data = "c:my/dir/key.pem"
        }
    }

    default_node_pool {
        name = "default"
        node_count = 1
        vm_size    = "Standard_DS1_v2"

    }

    service_principal {
        client_id = "var.client_id"
        client_secret = "var.client_secret" 
    }

    tags = {
        Environment = "var.Environment"
    } 


}

terraform {
    backend "azurerm" {
        #storage_account_name = ""
        #access_key = ""
        #key = ""
        #container = ""
    }
}
