resource "azurerm_resource_group" "example" {
  name     = "example-resources-mysql"
  location = "West Europe"
}

resource "random_string" "random" {
  length           = 14
  special          = false
  override_special = "/@£$"
  upper            = false
}



resource "random_password" "password" {
	length = 30
	special = false
	override_special = "_%@"
  upper            = true
}



resource "azurerm_mysql_server" "example" {
  name                              = "example-mysqlserver-2-${random_string.random.result}"
  location                          = azurerm_resource_group.example.location
  resource_group_name               = azurerm_resource_group.example.name
  administrator_login               = "mysqladminun"
  administrator_login_password      = random_password.password.result
  sku_name                          = "B_Gen5_2"
  storage_mb                        = 5120
  version                           = "5.7"
  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
}



output address {
  value = azurerm_mysql_server.example.fqdn
}


output user {
  value = "mysqladminun@example-mysqlserver-2-${random_string.random.result}"
}