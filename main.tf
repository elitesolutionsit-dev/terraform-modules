module "database" {

  source                       = "./modules/database/"
  dbRGname                     = var.dbRGname
  server                       = lower("ELITE")
  buildregion                  = upper("eastus2")
  storageaccount               = join("", ["elitestorage"])
  sqlserver                    = "sqladmin"
  administrator_login          = "sqladmin"
  dbname                       = "elitedevdb"
  fwRulename                   = "dbfwRule"
  start_ip_address             = "70.114.65.185"
  end_ip_address               = "70.114.65.185"
  administrator_login_password = var.administrator_login_password

  depends_on = [azurerm_resource_group.rgdb]
}

module "virtualnetwork" {

  source              = "./modules/virtualnetwork/"
  vnet_name           = join("-", ["elite", "vnetdev"])
  tags                = local.network_tag
  subnet_names        = local.subnet_names
  address_space       = local.address_space
  subnet_prefixes     = local.subnet_prefixes
  resource_group_name = local.resource_group_name
  route_tables_ids = {
    application = azurerm_route_table.rtb.id
    database    = azurerm_route_table.rtb.id
    servers     = azurerm_route_table.rtb.id
  }
  nsg_ids = {
    application = azurerm_network_security_group.nsg.id
    database    = azurerm_network_security_group.nsg.id
    servers     = azurerm_network_security_group.nsg.id
  }

  depends_on = [azurerm_resource_group.rg]
}

locals {
  ui-beap      = join("", ["ui-beap"])
  apibeap      = join("", ["api-beap"])
  uihtst       = join("", ["ui-htst"])
  api-htst     = join("", ["api-htst"])
  httplistener = join("", ["http-listener"])
  httprqrt     = join("", ["http-rqrt"])
  fe-pip       = join("", ["fe-pip"])
  feconfig     = join("", ["feconfig"])
}

module "applicationgateway" {
  source = "./modules/applicationgateway"

  backend_http_settings = [{
    name                  = local.uihtst
    path                  = "/"
    request_timeout       = 60
    cookie_based_affinity = "Enabled"
    },
    {
      name                  = "Elite-development-bhst"
      path                  = "/app"
      request_timeout       = 60
      cookie_based_affinity = "Enabled"
    }
  ]

  http_listener = [{
    name                           = local.httplistener
    frontend_ip_configuration_name = "name-pip"
    frontend_port_name             = "port80"
    protocol                       = "Http"
    }
  ]

  request_routing_rule = [{
    name                       = local.httprqrt
    http_listener_name         = local.httplistener
    backend_address_pool_name  = "beapname"
    backend_http_settings_name = local.uihtst
    priority                   = "10"
    }
  ]
}