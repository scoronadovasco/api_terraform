terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.55.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg_api_net"
    storage_account_name = "storageaccountapinet"
    container_name = "terraform"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = var.subscription_id
}
