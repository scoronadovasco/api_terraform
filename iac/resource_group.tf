resource "azurerm_resource_group" "RG_API_NET" {
  name     = "rg_api_net"
  location = "eastus"
  tags = {
    "description" = "grupo de recursos para la api de .net"
    "src"         = "terraform"
  }
}
