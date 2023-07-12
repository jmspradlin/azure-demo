output "azure_lb_url" {
  value = azurerm_public_ip.pip.fqdn
}