resource "azurerm_mssql_server" "api-net-sqlserver" {
  name                          = "api-net-sqlserver-1205"
  resource_group_name           = azurerm_resource_group.RG_API_NET.name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.userdb
  administrator_login_password  = var.userdbpass
  public_network_access_enabled = true
  
  # Configuración mínima de seguridad TLS
  minimum_tls_version = "1.2"
}

resource "azurerm_mssql_database" "sqldatabase-apinet" {
  name           = "api-net-db"
  server_id      = azurerm_mssql_server.api-net-sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "Basic"
  zone_redundant = false

  tags = {
    foo = "bar"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Regla para permitir servicios de Azure (Container Apps, Functions, etc.)
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.api-net-sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Regla específica para Container App outbound IP
resource "azurerm_mssql_firewall_rule" "allow_container_app" {
  name             = "AllowContainerApp"
  server_id        = azurerm_mssql_server.api-net-sqlserver.id
  start_ip_address = "52.226.99.237"
  end_ip_address   = "52.226.99.237"
}
