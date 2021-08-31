output "ResourceGroupName" {  
    description = "name of the resource group provisioned"  
    value = "${azurerm_resource_group.newrg.name}"  
}  