variable "kvs" {
    type = map(object({
     key_vault_name      =  string
  location                    = string
  resource_group_name         = string
  enabled_for_disk_encryption = bool
  tenant_id                   = string
  soft_delete_retention_days  = number
  purge_protection_enabled    = bool
  sku_name = string
  object_id = string
  key_permissions = list(string)
  

    }))
  
}