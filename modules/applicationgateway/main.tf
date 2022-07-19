#/*------------ Https Appgw Association --------------------*\#
# resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "beapassoc" {
#   network_interface_id    = data.azurerm_network_interface.vm-nic.id
#   ip_configuration_name   = local.ipconfname
#   backend_address_pool_id = tolist(azurerm_application_gateway.network.backend_address_pool).0.id
# }

resource "azurerm_public_ip" "appgw-pip" {
  name                = "appgwpip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = var.sku_tier == "WAF_v2" ? "Static" : "Dynamic"
  sku                 = var.sku_tier == "WAF_v2" ? "Standard" : "WAF_v2"
  tags                = local.appgw_tags
}

resource "azurerm_subnet" "appgw-subnet" {
  name                 = "appgwsubnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnetname.name
  address_prefixes     = ["10.0.3.0/24"]
}

#/*------------ Http Appgw --------------------*\#
resource "azurerm_application_gateway" "network" {
  name                = join("-", [local.rgappw, "devgateway"])
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.buildregion

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = join("-", [local.rgappw, "ipconf"])
    subnet_id = azurerm_subnet.appgw-subnet.id
  }

  frontend_port {
    name = "port80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "name-pip"
    public_ip_address_id = azurerm_public_ip.appgw-pip.id
  }

  backend_address_pool {
    name = "beapname"
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      path                  = backend_http_settings.value.path
      port                  = "80"
      protocol              = "Http"
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }
  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = "Http"
    }
  }
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = "Basic"
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      priority                   = request_routing_rule.value.priority
    }
  }
  tags = local.appgw_tags
}