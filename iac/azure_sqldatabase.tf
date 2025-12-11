resource "azurerm_mssql_server" "api-net-sqlserver" {
  name                         = "api-net-sqlserver-1205"
  resource_group_name          = azurerm_resource_group.RG_API_NET.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.userdb
  administrator_login_password = var.userdbpass
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

resource "azurerm_mssql_firewall_rule" "sql_rule" {
  end_ip_address   = "0.0.0.0"
  start_ip_address = "0.0.0.0"
  server_id        = azurerm_mssql_server.api-net-sqlserver.id
  name             = "azsql-firewall-rule"
}
