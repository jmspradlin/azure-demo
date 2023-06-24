resource "azurerm_resource_group" "rg01" {
  name = var.rg_name
  location = var.rg_location
}

resource "random_string" "sa_name" {
  length  = 6
  special = false
  upper   = false
  lower   = true
  numeric  = true
}

resource "azurerm_storage_account" "sa01" {
  name                = "${var.sa_name}${random_string.sa_name.result}"
  resource_group_name = azurerm_resource_group.rg01.name
}