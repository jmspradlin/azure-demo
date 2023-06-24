resource "azurerm_resource_group" "rg01" {
  name = "adopt-rg01"
}

resource "random_string" "sa_name" {
  length  = 6
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "azurerm_storage_account" "sa01" {
  name                = "${var.storage_account.name}${random_string.sa_name.result}"
  resource_group_name = azurerm_resource_group.rg01.name
}