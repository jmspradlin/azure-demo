resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.env}-${var.rg.name}-01"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  dns_prefix          = "${var.env}-${var.rg.name}-01"
  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.subnets["default_node_pool"].id
  }
  network_profile {
    network_plugin = "azure"
    network_mode   = "bridge"
    network_policy = "azure"
    service_cidrs  = azurerm_subnet.subnets["default_node_pool"].address_prefixes
  }

  identity {
    type = "SystemAssigned"
  }

}