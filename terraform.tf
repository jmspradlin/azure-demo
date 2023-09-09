terraform {


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.72.0"
    }
  }
  required_version = ">= 1.4.6"

  cloud {
    organization = "jeff-spradlin-org"

    workspaces {
      name = "azure-demo-aks"
    }
  }


}