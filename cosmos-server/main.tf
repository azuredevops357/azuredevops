provider "azurerm" {
  version = "~> 1.34.0"
}
resource "azurerm_resource_group" "rg" {
  name = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}
resource "azurerm_cosmosdb_account" "demoacc" {
  name = "${var.cosmos_db_account_name}"
  location = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  offer_type = "Standard"
  kind = "GlobalDocumentDB"
  enable_automatic_failover = true
  consistency_policy {
    consistency_level = "Session"
  }
  
  geo_location {
    location = "${var.failover_location}"
    failover_priority = 1
  }
  geo_location {
    location = "${var.resource_group_location}"
    failover_priority = 0
  }
}
resource "azurerm_cosmosdb_sql_database" "db" {
  name = "products"
  resource_group_name = "${azurerm_cosmosdb_account.demoacc.resource_group_name}"
  account_name = "${azurerm_cosmosdb_account.demoacc.name}"
}
resource "azurerm_cosmosdb_sql_container" "demosql" {
  name = "cosmossql"
  resource_group_name = "${azurerm_cosmosdb_account.demoacc.resource_group_name}"
  account_name = "${azurerm_cosmosdb_account.demoacc.name}"
  database_name = "${azurerm_cosmosdb_sql_database.db.name}"
  partition_key_path = "/cosmossqlID"
}