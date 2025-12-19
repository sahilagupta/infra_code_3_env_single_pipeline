rgs = {
  rg1 = {
    rg_name  = "todo-rg1"
    location = "centralus"

    # managed_by = "own"
    tags = {
      owner = "God"

    }
  }

  rg2 = {
    rg_name    = "todo-rg2"
    location   = "centralus"
    managed_by = "terraform"
    # tags = {
    #     owner = "prithvi"

    # }
  }
}

vnets = {
  vnet1 = {
    vnet_name           = "todo-vnet1"
    location            = "centralus"
    resource_group_name = "todo-rg1"
    address_space       = ["10.15.0.0/16"]

    subnets = {
      subnet1 = {
        subnet_name      = "frontend-subnet1"
        address_prefixes = ["10.15.0.0/24"]
      }
      subnet2 = {
        subnet_name      = "backend-subnet1"
        address_prefixes = ["10.15.2.0/24"]
      }
      bastion = {
        subnet_name      = "AzureBastionSubnet"
        address_prefixes = ["10.15.3.0/26"]
      }
    }
  }
}

pips = {
  pip1 = {
    pip_name            = "frontend-pip1"
    resource_group_name = "todo-rg1"
    location            = "centralus"
    allocation_method   = "Static"
  }
  pip2 = {
    pip_name            = "backend-pip1"
    resource_group_name = "todo-rg1"
    location            = "centralus"
    allocation_method   = "Static"
  }
  # pip3 = {
  #   pip_name            = "bastion-pip1"
  #   resource_group_name = "todo-rg1"
  #   location            = "centralus"
  #   allocation_method   = "Static"
  # }
  #  pip4 = {
  #   pip_name            = "todo-lb-pip1"
  #   resource_group_name = "todo-rg1"
  #   location            = "centralus"
  #   allocation_method   = "Static"
  # }


}

# kvs = {
#   kv1 = {

#     key_vault_name              = "todo-vv-kv1"
#     location                    = "centralus"
#     resource_group_name         = "todo-rg1"
#     enabled_for_disk_encryption = true
#     tenant_id                   = "e36e2232-cac4-497a-9243-862b9b46221b"
#    soft_delete_retention_days  = 7
#     purge_protection_enabled    = false
#     sku_name                    = "standard"
#     object_id                   = "ccbe7277-7d12-4151-aed9-88d57292ce25"
#     key_permissions             = ["Get", "List", "Delete"]


#   }
# }

vms = {
  vm1 = {
    subnet_name          = "frontend-subnet1"
    virtual_network_name = "todo-vnet1"
    resource_group_name  = "todo-rg1"
    pip_name             = "frontend-pip1"
    nic_name             = "frontend-nic1"
    location             = "centralus"
    vm_name              = "frontend-vm"
    size                 = "Standard_B1s"

    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-jammy"
    sku            = "22_04-lts"
    version        = "latest"
    # key_vault_name = "todo-vv-kv1"
    script_name = "nginx.sh"
    nsg_key = "frontend-nsg"

  }

  vm2 = {
    subnet_name          = "backend-subnet1"
    virtual_network_name = "todo-vnet1"
    resource_group_name  = "todo-rg1"
    pip_name             = "backend-pip1"
    nic_name             = "backend-nic1"
    location             = "centralus"
    vm_name              = "backend-vm"
    size                 = "Standard_B2s"

    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-jammy"
    sku            = "22_04-lts"
    version        = "latest"
    # key_vault_name = "todo-vv-kv1"
    script_name = null
    nsg_key = "backend-nsg" 
    
  }
}

nsgs = {
  frontend-nsg = {
    nsg_name            = "frontend-nsg"
    location            = "centralus"
    resource_group_name = "todo-rg1"
    security_rules = {
      security_rule1 = {
        sg_name                    = "allow_ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      security_rule2 = {
        sg_name                    = "allow_http"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }


 backend-nsg = {
    nsg_name            = "backend-nsg"
    location            = "centralus"
    resource_group_name = "todo-rg1"
    security_rules = {
      allow_ssh = {
        sg_name                    = "allow_ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      allow_backend_ports = {
        sg_name                    = "allow_backend_ports"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8000"   # backend ports
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}