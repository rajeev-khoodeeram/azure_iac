data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "security_rg" {
  name     = "rg-platform-security"
  location = var.location
}

resource "azurerm_key_vault" "platform_kv" {
  name                = "kv-platform-shared001"
  location            = azurerm_resource_group.security_rg.location
  resource_group_name = azurerm_resource_group.security_rg.name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"

  purge_protection_enabled   = true
  soft_delete_retention_days = 90
  rbac_authorization_enabled = true
}