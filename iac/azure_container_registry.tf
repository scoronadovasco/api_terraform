
resource "azurerm_container_registry" "acr_api_net" {
  name                = "containerapinet"
  resource_group_name = azurerm_resource_group.RG_API_NET.name
  location            = azurerm_resource_group.RG_API_NET.location
  sku                 = "Standard"
  admin_enabled       = true
  tags = merge(var.tags, {
    "descriptipn" = "container for docker images"
  })
}
