locals {    
    rg_name = replace((length(var.resource_group_name) > 64 ? substr(var.resource_group_name, 0, 63) : var.resource_group_name), " ", "-")  
}  