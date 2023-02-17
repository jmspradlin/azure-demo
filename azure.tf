# resource "azurerm_resource_group" "rg01" {
#   name     = "${var.env}-${var.rg.name}-01"
#   location = var.rg.location
# }

# resource "azurerm_virtual_network" "vnet" {
#   name                = var.vnet.name
#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location
#   address_space       = [var.vnet.address_space]
# }

# resource "azurerm_subnet" "subnets" {
#   for_each = var.subnets

#   name                 = each.key
#   resource_group_name  = azurerm_resource_group.rg01.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = each.value.address_prefixes
# }

# # resource "azurerm_public_ip" "pip" {
# #   for_each 
# #   name                = var.vnet.public_ip
# #   resource_group_name = azurerm_resource_group.rg01.name
# #   location            = azurerm_resource_group.rg01.location
# #   allocation_method   = "Static"
# #   sku         = "Standard"
# #   zones                = ["1", "2", "3"]
# # }

# # resource "azurerm_lb" "public_lb" {
# #   name                = var.azure_load_balancer.name
# #   resource_group_name = azurerm_resource_group.rg01.name
# #   location            = azurerm_resource_group.rg01.location
# #   sku                 = "Standard"
# #   sku_tier            = "Regional"
# #   frontend_ip_configuration {
# #     name                 = "PublicIP"
# #     #public_ip_address_id = azurerm_public_ip.pip.id
# #     zones                = ["1", "2", "3"]
# #   }
# # }

# # resource "azurerm_lb_backend_address_pool" "public_lb" {
# #   loadbalancer_id = azurerm_lb.public_lb.id
# #   name            = var.azure_load_balancer.backend_pool_name
# # }

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

# # resource "azurerm_subnet_network_security_group_association" "public" {
# #   for_each                  = toset([azurerm_subnet.subnets["frontend"].id])
# #   subnet_id                 = each.value
# #   network_security_group_id = azurerm_network_security_group.public.id
# # }

# # resource "azurerm_subnet_network_security_group_association" "private" {
# #   for_each = toset([azurerm_subnet.subnets["zone1"].id,
# #     azurerm_subnet.subnets["zone2"].id,
# #     azurerm_subnet.subnets["zone3"].id,
# #   ])
# #   subnet_id                 = each.value
# #   network_security_group_id = azurerm_network_security_group.private.id
# # }

# # resource "azurerm_network_interface_backend_address_pool_association" "backend" {
# #   for_each                = module.azure_linux_servers
# #   network_interface_id    = each.value.network_interface_ids[0]
# #   ip_configuration_name   = "${each.key}-ip-0"
# #   backend_address_pool_id = azurerm_lb_backend_address_pool.public_lb.id
# # }

# # output "networkinterfaceid" {
# #     value = module.azure_linux_servers["azure01"].network_interface_ids[0]
# # }
# resource "random_password" "azure" {
#   length           = 32
#   special          = true
#   override_special = "$%&*?"
# }

# module "azure_linux_servers" {
#   for_each = var.azure_linux_vms
#   source   = "Azure/compute/azurerm"
#   #version  = ">= 5.1.0"

#   resource_group_name = azurerm_resource_group.rg01.name
#   location            = azurerm_resource_group.rg01.location
#   vm_hostname         = each.key
#   vm_os_offer         = "centos"
#   vm_os_publisher     = "OpenLogic"
#   vm_os_sku           = "7.5"
#   vm_size             = each.value.size
#   enable_ssh_key      = false
#   admin_password      = random_password.azure.result

#   # Networking
#   vnet_subnet_id = azurerm_subnet.subnets["${each.value.zone}"].id
#   nb_public_ip   = 1
#   public_ip_sku  = "Standard"
#   allocation_method = "Static"
#   network_security_group = azurerm_network_security_group.public

#   # Data
#   delete_data_disks_on_termination = true
#   delete_os_disk_on_termination    = true
#   remote_port                      = 80
#   custom_data                      = base64encode(data.template_file.setup_site[each.key].rendered)
#   #[
#   #     {
#   #       name                 = "hostname"
#   #       publisher            = "Microsoft.Azure.Extensions",
#   #       type                 = "CustomScript",
#   #       type_handler_version = "2.0",
#   #       settings = <<SETTINGS
#   #             {
#   #                 "script": "${base64encode(templatefile("custom_script.sh", {
#   #       vmname = "${each.key},", logo = "${each.value.size}", color = "${each.value.color}"
#   # }))}"
#   #             }
#   #             SETTINGS
#   # }
#   # ]

#   depends_on = [azurerm_resource_group.rg01]
#   zone       = substr("${each.value.zone}", 4, 1)
# }