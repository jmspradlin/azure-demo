variable "sa_name" {
  description = "Core name of the storage account to deploy. Pairs with a random 6-character string to create a globally unique storage account name."
}

variable "rg_name" {
  description = "Name of the primary Resource Group"
}

variable "rg_location" {
  description = "Location for the Resource Group and Resources"
}

variable "sa_account_tier" {
  description = "Tier for the storage account"
}

variable "sa_account_replication_type" {
  description = "Replication level for the storage account (e.g. LRS, GRS, ZRS, etc.)"
}