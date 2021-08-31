provider "azurerm" {
  version = "2.74.0"
  features{}
}
resource "azurerm_resource_group" "newrg" {
 name = var.resource_group_name
 location = var.location
}