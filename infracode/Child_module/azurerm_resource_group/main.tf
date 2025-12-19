
resource "azurerm_resource_group" "rg" {
    for_each = var.rgs
    name = each.value.rg_name
    # name = format("%s-%s-%s",coalesce(lookup(each.value, "prefix", null),var.default_prefix),lookup(each.value, "name", each.key ), coalesce(lookup(each.value, "suffix", null),var.default_suffix))
    # name = "${lookup(each.value, "prefix", var.default_prefix) != null ? lookup(each.value, "prefix" , var.default_prefix) : var.default_prefix}-${lookup(each.value, "name", each.key)}-${lookup(each.value, "suffix", var.default_suffix) != null ? lookup(each.value, "suffix" , var.default_suffix) : var.default_suffix}"
    #  name = "${lookup(each.value, "prefix", var.default_prefix)}-${lookup(each.value, "name", each.key)}-${lookup(each.value, "suffix", var.default_suffix)}"
    location = each.value.location
    # managed_by = lookup(each.value, "managed_by", "nokia") != null ? lookup(each.value, "managed_by", "nokia") : "nokia"
    #  managed_by = coalesce(lookup(each.value,"managed_by","nokia"), "eric" ) 
       managed_by = coalesce(try(each.value.managed_by),"nokia")
        # managed_by = lookup(each.value, "managed_by", "nokia")
        tags = each.value.tags
        }

        output "rg_managed_by" {
  value = { for k, v in azurerm_resource_group.rg : k => v.managed_by }
}
