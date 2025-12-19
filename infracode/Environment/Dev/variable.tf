variable "rgs" {
  type = map(object({
    rg_name    = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))

    }

  ))
}

variable "vnets" {
  type = map(object({
    vnet_name           = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    subnets = map(object({
      subnet_name      = string
      address_prefixes = list(string)

    }))

    }

  ))
}

variable "pips" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string
  }))
}

# variable "kvs" {
#   type = map(object({
#     key_vault_name              = string
#     location                    = string
#     resource_group_name         = string
#     enabled_for_disk_encryption = bool
#     tenant_id                   = string
#     soft_delete_retention_days  = number
#     purge_protection_enabled    = bool
#     sku_name                    = string
#     object_id                   = string
#     key_permissions             = list(string)


#   }))

# }

variable "vms" {
  type = map(object({
    subnet_name          = string
    virtual_network_name = string
    resource_group_name  = string
    pip_name             = string
    nic_name             = string
    location             = string
    vm_name              = string
    size                 = string
    script_name = optional(string)

    publisher      = string
    offer          = string
    sku            = string
    version        = string
    # key_vault_name = string
    nsg_key              = string  

  }))

}
variable "nsgs" {}
