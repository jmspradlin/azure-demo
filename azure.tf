resource "azurerm_resource_group" "rg01" {
  name     = "${var.env}-${var.rg.name}-01"
  location = var.rg.location
}

# Networking
# Vnet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  address_space       = [var.vnet.address_space]
}
# Subnet
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg01.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}

# Public IP
resource "azurerm_public_ip" "pip" {
  #for_each 
  name                = var.vnet.public_ip
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  allocation_method   = "Dynamic"
}

locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.vnet.name}-rdrcfg"
}

# resource "azurerm_application_gateway" "k8s" {
#   name                = "${var.env}-${var.rg.name}-agw01"
#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location

#   sku {
#     name     = "Standard_Small"
#     tier     = "Standard"
#     capacity = 2
#   }

#   gateway_ip_configuration {
#     name      = "my-gateway-ip-configuration"
#     subnet_id = azurerm_subnet.subnet["app_gateway_front_end"].id
#   }

#   frontend_port {
#     name = local.frontend_port_name
#     port = 80
#   }

#   frontend_ip_configuration {
#     name                 = local.frontend_ip_configuration_name
#     public_ip_address_id = azurerm_public_ip.pip.id
#   }

#   backend_address_pool {
#     name = local.backend_address_pool_name
#   }

#   backend_http_settings {
#     name                  = local.http_setting_name
#     cookie_based_affinity = "Disabled"
#     path                  = "/path1/"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 60
#   }

#   http_listener {
#     name                           = local.listener_name
#     frontend_ip_configuration_name = local.frontend_ip_configuration_name
#     frontend_port_name             = local.frontend_port_name
#     protocol                       = "Http"
#   }

#   request_routing_rule {
#     name                       = local.request_routing_rule_name
#     rule_type                  = "Basic"
#     http_listener_name         = local.listener_name
#     backend_address_pool_name  = local.backend_address_pool_name
#     backend_http_settings_name = local.http_setting_name
#   }
# }

# Security Groups and Rules
# resource "azurerm_network_security_group" "public" {
#   name                = "${var.nsg.name}-public"
#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location
# }
# resource "azurerm_network_security_group" "private" {
#   name                = "${var.nsg.name}-private"
#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location
# }
# resource "azurerm_network_security_rule" "public" {
#   for_each = var.nsg_rules_public

#   name                        = each.key
#   priority                    = each.value.priority
#   direction                   = each.value.direction
#   access                      = "Allow"
#   protocol                    = each.value.protocol
#   source_port_range           = each.value.source_port_range
#   destination_port_range      = each.value.destination_port_range
#   source_address_prefix       = each.value.source_address_prefix
#   destination_address_prefix  = each.value.destination_address_prefix
#   resource_group_name         = azurerm_resource_group.rg01.name
#   network_security_group_name = azurerm_network_security_group.public.name
# }
# resource "azurerm_network_security_rule" "private" {
#   for_each = var.nsg_rules_private

#   name                        = each.key
#   priority                    = each.value.priority
#   direction                   = each.value.direction
#   access                      = "Allow"
#   protocol                    = each.value.protocol
#   source_port_range           = each.value.source_port_range
#   destination_port_range      = each.value.destination_port_range
#   source_address_prefix       = each.value.source_address_prefix
#   destination_address_prefix  = each.value.destination_address_prefix
#   resource_group_name         = azurerm_resource_group.rg01.name
#   network_security_group_name = azurerm_network_security_group.private.name
# }


# # Load Balancer
# resource "azurerm_lb" "ingress" {
#   name                = var.azure_load_balancer.name
#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location
#   sku                 = "Standard"
#   sku_tier            = "Regional"
#   frontend_ip_configuration {
#     name                 = "PublicIP"
#     public_ip_address_id = azurerm_public_ip.pip.id
#   }
# }
# # LB Backend
# # Probe
# resource "azurerm_lb_probe" "public_lb" {
#   loadbalancer_id = azurerm_lb.public_lb.id
#   name            = "http-probe"
#   port            = 80
# }
# # Load balancing rule
# resource "azurerm_lb_rule" "public_lb" {
#   loadbalancer_id                = azurerm_lb.public_lb.id
#   name                           = "httpRule"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   frontend_ip_configuration_name = "PublicIP"
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.public_lb.id]
#   probe_id                       = azurerm_lb_probe.public_lb.id
# }
# # Backend Pool and Association
# resource "azurerm_lb_backend_address_pool" "public_lb" {
#   loadbalancer_id = azurerm_lb.public_lb.id
#   name            = var.azure_load_balancer.backend_pool_name
# }
# resource "azurerm_network_interface_backend_address_pool_association" "backend" {
#   for_each                = module.azure_linux_servers
#   network_interface_id    = each.value.network_interface_ids[0]
#   ip_configuration_name   = "${each.key}-ip-0"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.public_lb.id
# }

# Compute
# resource "random_password" "azure" {
#   length           = 32
#   special          = true
#   override_special = "$%&*?"
# }

# module "azure_linux_servers" {
#   for_each = var.azure_linux_vms
#   source   = "Azure/compute/azurerm"

#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location
#   vm_hostname         = each.key
#   enable_ssh_key      = false
#   vm_os_id            = each.value.os_id
#   vm_size             = each.value.size
#   admin_password      = random_password.azure.result

#   # Networking
#   vnet_subnet_id         = azurerm_subnet.subnets["${each.value.zone}"].id
#   nb_public_ip           = 0
#   network_security_group = azurerm_network_security_group.private

#   # Data
#   delete_data_disks_on_termination = true
#   delete_os_disk_on_termination    = true
#   remote_port                      = 80

#   depends_on = [azurerm_resource_group.rg01]
#   zone       = substr("${each.value.zone}", 4, 1)
# }