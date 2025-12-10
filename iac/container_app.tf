resource "azurerm_log_analytics_workspace" "azlaw-api-net" {
  name                = "azlaw-api-net"
  location            = azurerm_resource_group.RG_API_NET.location
  resource_group_name = azurerm_resource_group.RG_API_NET.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = merge(var.tags, {
    "description" = "azure log analytics for api web net"
  })
}

resource "azurerm_container_app_environment" "azc_api_net_enviroment" {
  name                       = "azc-api-net-Environment"
  location                   = azurerm_resource_group.RG_API_NET.location
  resource_group_name        = azurerm_resource_group.RG_API_NET.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.azlaw-api-net.id
  tags                       = var.tags
}

resource "azurerm_container_app" "azcapp-api-net" {
  name                         = "aca-api-net"
  container_app_environment_id = azurerm_container_app_environment.azc_api_net_enviroment.id
  resource_group_name          = azurerm_resource_group.RG_API_NET.name
  revision_mode                = "Multiple"

  template {
    min_replicas = 1
    max_replicas = 3
    container {
      name   = "aca-api-net-app"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"

    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 8080
    traffic_weight {
      percentage = 100
      label = "primary"
      latest_revision = true

    }
  }
  tags = var.tags
}
