rg = {
  name      = "multicloud"
  location  = "northcentralus"
}
app_service_plan = {
  name = "app-service-plan01"
  sku_name = "F1"
  os = "Linux"
}

app_service_linux = {
    ltldemoapp01 = {}
    ltldemoapp02 = {}
}