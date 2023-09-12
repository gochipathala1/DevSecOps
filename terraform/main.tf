locals {
  org-name  = "my-org"
  dept-name = "my-dept"
  common-tags = {
    prefix = "${local.org-name}-${local.dept-name}"
  }
}

resource "random_string" "stg-random" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.region
}

module "storage" {
  source = "./module/storage"

  sa-name                  = "${var.sa-name}${random_string.stg-random.id}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.region
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  common-tags              = local.common-tags
}

module "network" {
  source = "./module/network"

  name                = var.vnet-name
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space

  address_prefixes = var.address_prefixes
  vm-count         = var.vm-count

  common-tags = local.common-tags
}

module "compute" {
  source = "./module/compute"

  vm-count            = var.vm-count
  nics                = module.network.nics
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
}