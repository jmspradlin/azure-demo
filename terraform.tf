terraform {
  cloud {
    organization = "jeff-spradlin-org"

    workspaces {
      name = "azure-demo-adopt"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.59.0"
    }
  }

  required_version = ">= 1.1.0"
}