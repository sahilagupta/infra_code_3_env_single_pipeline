
resource "azurerm_virtual_network" "vnet" {
    for_each = var.vnets
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  

  dynamic "subnet" {
    for_each = each.value.subnets
    content {

    name             = subnet.value.subnet_name
    address_prefixes = subnet.value.address_prefixes
  }
    
  }
  
}

