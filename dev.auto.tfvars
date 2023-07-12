rg = {
  name     = "azure-tfc"
  location = "eastus2"
}
env = "dev"

# Azure resources
vnet = {
  name          = "lab01"
  address_space = "10.0.2.0/23"
  public_ip     = "loudtreelabstfc"
}
subnets = {
  frontend = {
    address_prefixes = ["10.0.2.0/27"]
  },
  # frontend2 = {
  #   address_prefixes = ["10.0.2.32/27"]
  # },
  # frontend3 = {
  #   address_prefixes = ["10.0.2.64/27"]
  # },
  zone1 = {
    address_prefixes = ["10.0.3.0/27"]
  },
  zone2 = {
    address_prefixes = ["10.0.3.32/27"]
  },
  zone3 = {
    address_prefixes = ["10.0.3.64/27"]
  },
}
azure_load_balancer = {
  name              = "loudtreelabtfc"
  backend_pool_name = "backendpool"
}
azure_linux_vms = {
  azure01 = {
    zone  = "zone1"
    os_id = ""
    size  = "Standard_D2s_v3"
    logo  = "https://en.wikipedia.org/wiki/Microsoft_Azure#/media/File:Microsoft_Azure.svg"
    color = "#008AD7"
  }
#   azure02 = {
#     zone  = "zone2"
#     os_id = "/subscriptions/5bec1c2b-e676-4885-9da2-3de4af44d3a4/resourceGroups/linux-packer-image-rg/providers/Microsoft.Compute/images/linuxvmtest02"
#     size  = "Standard_D2s_v3"
#     logo  = "https://en.wikipedia.org/wiki/Microsoft_Azure#/media/File:Microsoft_Azure.svg"
#     color = "#00A2ED"
#   }
#   azure03 = {
#     zone  = "zone3"
#     os_id = "/subscriptions/5bec1c2b-e676-4885-9da2-3de4af44d3a4/resourceGroups/linux-packer-image-rg/providers/Microsoft.Compute/images/linuxvmtest03"
#     size  = "Standard_D2s_v3"
#     logo  = "https://en.wikipedia.org/wiki/Microsoft_Azure#/media/File:Microsoft_Azure.svg"
#     color = "#FAF9F6"
#   }
}
nsg = {
  name = "testnsg01"
}
nsg_rules_public = {
  outbound1 = {
    priority                   = 100
    direction                  = "Outbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  inbound1 = {
    priority                   = 101
    direction                  = "Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  inbound2 = {
    priority                   = 102
    direction                  = "Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "66.169.181.135"
    destination_address_prefix = "*"
  }
}
nsg_rules_private = {
  outbound1 = {
    priority                   = 100
    direction                  = "Outbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  inbound = {
    priority                   = 101
    direction                  = "Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}