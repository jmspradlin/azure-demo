rg = {
  name     = "azure-aks"
  location = "eastus2"
}
env = "dev"
node_pool_tags = {
  default     = "true"
  OS          = "Ubuntu"
  environment = "dev"
}

# Azure resources
vnet = {
  name          = "lab01"
  address_space = "10.0.0.0/16"
  public_ip     = "loudtreelabstfc"
}
subnets = {
  private_link = {
    address_prefixes = ["10.0.255.0/24"]
  },
  app_gateway_front_end = {
    address_prefixes = ["10.0.254.0/25"]
  },
  app_gateway_back_end = {
    address_prefixes = ["10.0.254.128/25"]
  },
  ingress = {
    address_prefixes = ["10.0.253.0/24"]
  },
  default_node_pool = {
    address_prefixes = ["10.0.0.0/22"]
  },
  internal01 = {
    address_prefixes = ["10.0.4.0/22"]
  },
  internal02 = {
    address_prefixes = ["10.0.8.0/22"]
  },
}
azure_load_balancer = {
  name              = "loudtreelabtfc"
  backend_pool_name = "backendpool"
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