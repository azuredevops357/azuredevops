provider "azurerm" {
 subscription_id = "8d14eb39-1a20-41a9-b680-36f4a3248329"
 tenant_id = "500d9b91-ea09-40d4-bea3-d11e685d31cd"
 client_id = "b98cf083-b0eb-4330-9214-504950c111c6"
 client_secret = "1D8qq.MClcvMreA25-3mAJSx~DrlK7-YRt"
 features {}
}

resource "azurerm_resource_group" "azvmtest" {
  name     = "rgvmlnx321"
  location = "West Europe"
}

resource "azurerm_virtual_network" "azvmtest" {
  name                = "vmnet-789"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = "rgvmlnx321"
}

resource "azurerm_subnet" "azvmtest" {
  name                 = "subnet1"
  resource_group_name  = "rgvmlnx321"
  virtual_network_name = azurerm_virtual_network.azvmtest.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "azvmtest" {
  name                = "azvmtest-nic"
  location            = "West Europe"
  resource_group_name = "rgvmlnx321"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.azvmtest.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "azvmtest" {
  name                  = "azuretest-vm"
  location              = "West Europe"
  resource_group_name   = "rgvmlnx321"
  network_interface_ids = [azurerm_network_interface.azvmtest.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Dev"
  }
}