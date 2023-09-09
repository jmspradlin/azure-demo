
module "aks" {
  source  = "Azure/aks/azurerm"
  version = "7.3.2"
  resource_group_name = azurerm_resource_group.rg01.name
  location = azurerm_resource_group.rg01.location

  #Networking
  vnet_subnet_id = azurerm_subnet.subnet["default_node_pool"].id
  
  ingress_application_gateway_enabled = true
  ingress_application_gateway_name = "${var.env}-${var.rg.name}-agw01"
  ingress_application_gateway_subnet_id = azurerm_subnet.subnet["app_gateway_front_end"].id
  #Nodepool
  node_pools = {
    vm_size = "Standard_B2s"
    node_count = 1
    
  }
  #Storage
  #Identity
  identity_type = "SystemAssigned"
}