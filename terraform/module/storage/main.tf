locals {
  #add Locals here
  local-tag = {
    cot-tag = "1.0"
  }
}
resource "azurerm_storage_account" "storage-account" {
  name                     = var.sa-name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = merge(local.local-tag, var.common-tags)
}
