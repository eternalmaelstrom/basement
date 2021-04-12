resource "azurerm_storage_account" "rocalc" {
  name                     = "sa${local.namespace}rocalc${local.environment}"
  resource_group_name      = azurerm_resource_group.rocalc.name
  location                 = azurerm_resource_group.rocalc.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  allow_blob_public_access = true
  tags = {
    environment = "${local.environment}"
  }
}


resource "azurerm_storage_container" "rocalc" {
  name                  = "rocalc"
  storage_account_name  = azurerm_storage_account.rocalc.name
  container_access_type = "container"
}
