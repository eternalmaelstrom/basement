
resource "azurerm_cdn_profile" "rocalc" {
  name                = "cdn-${local.namespace}-${local.environment}"
  location            = azurerm_resource_group.rocalc.location
  resource_group_name = azurerm_resource_group.rocalc.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "rocalc" {
  name                = "cdn-rocalc-${local.namespace}-${local.environment}"
  profile_name        = azurerm_cdn_profile.rocalc.name
  location            = azurerm_resource_group.rocalc.location
  resource_group_name = azurerm_resource_group.rocalc.name

  origin_host_header = azurerm_storage_account.rocalc.primary_blob_host
  origin {
    name      = "rocalcweb"
    host_name = azurerm_storage_account.rocalc.primary_blob_host
  }

  delivery_rule {
    name  = "httptohttps"
    order = 1

    request_scheme_condition {
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }

  delivery_rule {
    name  = "forwardtoapp"
    order = 2
    url_file_extension_condition {
      operator     = "LessThan"
      match_values = ["1"]
    }

    url_rewrite_action {
      source_pattern = "/"
      destination    = "/rocalc/index.html"
    }
  }

}
