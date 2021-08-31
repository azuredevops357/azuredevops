provider "azurerm" {
 subscription_id = "8d14eb39-1a20-41a9-b680-36f4a3248329"
 tenant_id = "500d9b91-ea09-40d4-bea3-d11e685d31cd"
 client_id = "b98cf083-b0eb-4330-9214-504950c111c6"
 client_secret = "1D8qq.MClcvMreA25-3mAJSx~DrlK7-YRt"
 features {}
}


resource "azurerm_resource_group" "azvmtest" {
  name     = "rgaztestvm231"
  location = "West Europe"
}

resource "azurerm_network_security_group" "azvmtest" {
  name                = "vmnet5671"
  location            = "West Europe"
  resource_group_name = "rgaztestvm231"
}

resource "azurerm_network_ddos_protection_plan" "azvmtest" {
  name                = "subnet1756"
  location            = "West Europe"
  resource_group_name = "rgaztestvm231"
}

resource "azurerm_virtual_network" "azvmtest" {
  name                = "vnet0537-test"
  location            = "West Europe"
  resource_group_name = "rgaztestvm231"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.azvmtest.id
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.azvmtest.id
  }

  tags = {
    environment = "Dev"
  }
}