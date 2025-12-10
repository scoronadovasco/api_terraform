resource "azurerm_log_analytics_workspace" "azlaw-api-net" {
  name                = "azlaw-api-net"
  location            = azurerm_resource_group.RG_API_NET.location
  resource_group_name = azurerm_resource_group.RG_API_NET.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = merge(var.tags,{
    "description" = "azure log analytics for api web net"
  })
}

resource "azurerm_container_app_environment" "azc_api_net_enviroment" {
  name                       = "azc-api-net-Environment"
  location                   = azurerm_resource_group.RG_API_NET.location
  resource_group_name        = azurerm_resource_group.RG_API_NET.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.azlaw-api-net.id
  tags = var.tags
}

resource "azurerm_container_app" "azcapp-api-net" {
  name                         = "api-net-app"
  container_app_environment_id = azurerm_container_app_environment.azc_api_net_enviroment.id
  resource_group_name          = azurerm_resource_group.RG_API_NET.name
  revision_mode                = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}