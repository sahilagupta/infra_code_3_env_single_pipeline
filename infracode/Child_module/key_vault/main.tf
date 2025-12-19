resource "azurerm_key_vault" "kv" {
    for_each = var.kvs
  name                        = each.value.key_vault_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = each.value.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = each.value.sku_name

  access_policy {
    tenant_id = each.value.tenant_id
    object_id = each.value.object_id

    key_permissions = each.value.key_permissions
      

    secret_permissions = [
      "Get","List","Set","Delete"
    ]

    storage_permissions = [
      "Get","List","Set","Delete"
    ]
  }
}
