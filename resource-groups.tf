resource "azurerm_resource_group" "rocalc" {
  name     = "rg-${local.namespace}-rocalc-${local.environment}"
  location = local.location
}