module "rg" {
  source  = "app.terraform.io/jeff-spradlin-org/rg/azurerm"
  version = "1.1.0"
  # insert required variables here
  env = var.rg_name
  rg_name = var.env
  rg_location = var.rg_location
}

terraform {
  cloud {
    organization = "jeff-spradlin-org"

    workspaces {
      name = "azure-demo-var"
    }
  }
}
provider "azurerm" {
  use_oidc = true
  features {}
}
variable "env" {}
variable "rg_name" {}
variable "rg_location" {}