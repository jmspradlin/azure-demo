resource "random_string" "sa_name" {
  length  = 6
  special = false
  upper   = false
  lower   = true
  numeric = true
}

resource "azurerm_resource_group" "rg01" {
  name     = "${random_string.sa_name.result}-rg01"
  location = var.rg_location
}

module "storageaccount" {
  source  = "app.terraform.io/jeff-spradlin-org/storageaccount/azurerm"
  version = "1.3.1"

  env     = var.env
  rg_name = azurerm_resource_group.rg01.name
  sa_name = random_string.sa_name.result
  network_rule_ip_rules = ["127.0.0.1"]
  account_replication_type = var.sa_account_replication_type
}