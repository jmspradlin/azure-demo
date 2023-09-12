module "rg" {
  source  = "app.terraform.io/jeff-spradlin-org/rg/azurerm"
  version = "1.0.0"
  # insert required variables here
  env = var.env
  rg = var.rg
}

terraform {
  cloud {
    organization = "jeff-spradlin-org"

    workspaces {
      name = "azure-demo-var"
    }
  }
}

variable "env" {}
variable "rg" {}