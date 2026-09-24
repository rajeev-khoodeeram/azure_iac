module "identity" {
  source = "./platform/identity"
}

module "networking" {
  source    = "./platform/networking"
  location  = var.location
  vnet_cidr = var.vnet_cidr
}

module "logging" {
  source   = "./platform/logging"
  location = var.location
}

module "security" {
  source   = "./platform/security"
  location = var.location
}

module "shared_services" {
  source   = "./platform/shared-services"
  location = var.location
}