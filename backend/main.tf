terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Random suffix for globally unique storage account name
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "state_rg" {
  name     = "rg-bank-tfstate-prod"
  location = "eastus"
}

resource "azurerm_storage_account" "state_sa" {
  name                     = "stbanktfstate${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.state_rg.name
  location                 = azurerm_resource_group.state_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS" # Geo-redundant storage for banking audit/disaster recovery
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true # Protects against accidental state file corruption/deletion
    delete_retention_policy {
      days = 30
    }
  }

  tags = {
    Environment = "Shared-Services"
    Purpose     = "Terraform-Remote-State"
    Compliance  = "Banking-Standard"
  }
}

resource "azurerm_storage_container" "state_container" {
  name                  = "tfstates"
  storage_account_name    = azurerm_storage_account.state_sa.name
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.state_sa.name
}

output "container_name" {
  value = azurerm_storage_container.state_container.name
}