resource "azurerm_resource_group" "network_rg" {
  name     = "rg-platform-network"
  location = var.location
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-platform-hub"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location

  address_space = [
    var.vnet_cidr
  ]
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name

  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = "snet-private-endpoints"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name

  address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "shared_services" {
  name                 = "snet-shared-services"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name

  address_prefixes = ["10.0.3.0/24"]
}