resource "azurerm_storage_account" "rocalc" {
  name                     = "sa${local.namespace}rocalc${local.environment}"
  resource_group_name      = azurerm_resource_group.rocalc.name
  location                 = azurerm_resource_group.rocalc.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = {
    environment = "${local.environment}"
  }
}

output "test" {
  value = azurerm_storage_account.rocalc.primary_web_host
}