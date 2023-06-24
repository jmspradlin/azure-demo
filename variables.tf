variable "sa_name" {
  description = "Core name of the storage account to deploy. Pairs with a random 6-character string to create a globally unique storage account name."
}

variable "rg_name" {
  description = "Name of the primary Resource Group"
}

variable "rg_location" {
  description = "Location for the Resource Group and Resources"
}