
data "azurerm_subnet" "subnet" {
    for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}



data "azurerm_public_ip" "pip" {
    for_each = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "kvid" {
  # for_each = var.vms
  name                = "todo-vk-kv1"
  resource_group_name = "kv-rg1"
}


data "azurerm_key_vault_secret" "vmuser" {
  # for_each = var.vms
  name         = "vmuser"
  key_vault_id = data.azurerm_key_vault.kvid.id
}

data "azurerm_key_vault_secret" "vmpass" {
  # for_each = var.vms
  name         = "vmpassword"
  key_vault_id = data.azurerm_key_vault.kvid.id
}

resource "azurerm_network_interface" "nic" {
    for_each = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id

  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  for_each = var.vms

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = var.nsg_ids[each.value.nsg_key]   # NSG name key use karo
}


resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.vmuser.value
  admin_password =  data.azurerm_key_vault_secret.vmpass.value
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]
  custom_data = (each.value.script_name != null ? base64encode(file(each.value.script_name)) : null)

  disable_password_authentication = false

  lifecycle {
    ignore_changes = [
      admin_username,
      admin_password
    ]
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}