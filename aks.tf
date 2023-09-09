
# module "aks" {
#   source              = "Azure/aks/azurerm"
#   version             = "7.3.2"
#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location

#   #Networking
#   vnet_subnet_id                        = azurerm_subnet.subnets["default_node_pool"].id
#   ingress_application_gateway_enabled   = true
#   ingress_application_gateway_name      = "${var.env}-${var.rg.name}-agw01"
#   ingress_application_gateway_subnet_id = azurerm_subnet.subnets["app_gateway_front_end"].id

#   #Nodepool
#   agents_size = "Standard_B2s"

#   #Storage
#   #Identity
#   identity_type = "SystemAssigned"
# }