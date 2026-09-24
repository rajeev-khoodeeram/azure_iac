resource "azurerm_resource_group" "logging_rg" {
  name     = "rg-platform-logging"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-platform-central"
  location            = azurerm_resource_group.logging_rg.location
  resource_group_name = azurerm_resource_group.logging_rg.name

  sku               = "PerGB2018"
  retention_in_days = 30
}