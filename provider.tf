provider "azurerm" {
  use_oidc = true
  skip_provider_registration = "true"
  features {}
}
