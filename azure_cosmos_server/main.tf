provider "azurerm" {
 subscription_id = "8d14eb39-1a20-41a9-b680-36f4a3248329"
 tenant_id = "500d9b91-ea09-40d4-bea3-d11e685d31cd"
 features {}
}
resource "azurerm_resource_group" "rg" {
  name = "azurerg12342"
  location = "West Europe"
}
resource "azurerm_cosmosdb_account" "acc" {
  name = "cosmosdbtestrg357"
  location = "West Europe"
  resource_group_name = "azurerg12342"
  offer_type = "Standard"
  kind = "GlobalDocumentDB"
  enable_automatic_failover = true
  consistency_policy {
    consistency_level = "Session"
  }
  
  geo_location {
    location = "East US"
    failover_priority = 1
  }
  geo_location {
    location = "West Europe"
    failover_priority = 0
  }
}
resource "azurerm_cosmosdb_sql_database" "db" {
  name = "products"
  resource_group_name = "azurerg12342"
  account_name = "cosmosdbtestrg357"
}
resource "azurerm_cosmosdb_sql_container" "coll" {
  name = "Clothes"
  resource_group_name = "azurerg12342"
  account_name = "cosmosdbtestrg357"
  database_name = "products"
  partition_key_version = 1
  throughput            = 400
  partition_key_path = "/Id"

  indexing_policy {
    indexing_mode = "Consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}