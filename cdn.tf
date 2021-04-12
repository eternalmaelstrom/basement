
resource "azurerm_cdn_profile" "rocalc" {
  name                = "cdn-${local.namespace}-${local.environment}"
  location            = azurerm_resource_group.rocalc.location
  resource_group_name = azurerm_resource_group.rocalc.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "rocalc" {
  name                = "cdn${local.namespace}rocalc${local.environment}"
  profile_name        = azurerm_cdn_profile.rocalc.name
  location            = azurerm_resource_group.rocalc.location
  resource_group_name = azurerm_resource_group.rocalc.name

  origin_host_header = azurerm_storage_account.rocalc.primary_web_host
  origin {
    name      = "rocalcweb"
    host_name = azurerm_storage_account.rocalc.primary_web_host
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
    name  = "forwardtoindex"
    order = 2

    url_path_condition {
      operator = "Any"
    }

    url_file_extension_condition {
      operator         = "Any"
      negate_condition = true
    }

    url_rewrite_action {
      source_pattern = "/"
      destination    = "/index.html"
    }
  }

}