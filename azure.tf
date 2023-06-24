resource "azurerm_resource_group" "rg01" {
  name = var.rg_name
}

resource "random_string" "sa_name" {
  length  = 6
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "azurerm_storage_account" "sa01" {
  name                = "${var.sa_name}${random_string.sa_name.result}"
  resource_group_name = azurerm_resource_group.rg01.name
}