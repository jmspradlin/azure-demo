rg = {
  name      = "azure-tfc"
  location  = "northcentralus"
}
app_service_plan = {
  name = "app-service-plan01"
  sku_name = "S1"
  os = "Linux"
}

app_service_linux = {
    ltldemoapp01 = {}
    ltldemoapp02 = {}
}