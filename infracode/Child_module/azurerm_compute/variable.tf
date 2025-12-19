variable "vms" {
    type = map(object({
        subnet_name = string
        virtual_network_name = string
        resource_group_name = string
        pip_name = string
        nic_name = string
        location = string
        vm_name = string
        size = string
       
        publisher = string
        offer = string
        sku = string
        version = string
        # key_vault_name = string
        script_name = optional(string)
        nsg_key              = string  
        
    }))
  
}
variable "nsg_ids" {
  description = "List of NSG IDs to associate with NICs"
}