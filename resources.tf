resource "azurerm_resource_group" "rg" {
  name     = "elite-vnetdevrg"
  location = local.buildregion
}

resource "azurerm_resource_group" "rgdb" {
  name     = join("-", [local.server, var.dbRGname])
  location = local.buildregion
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsgrule-ssh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = var.destination_address_prefix
  }
}

resource "azurerm_route" "route" {
  name                = "route1"
  resource_group_name = azurerm_resource_group.rg.name
  route_table_name    = azurerm_route_table.rtb.name
  address_prefix      = "10.0.0.0/16"
  next_hop_type       = "VnetLocal"
}

resource "azurerm_route_table" "rtb" {
  name                = var.rtb
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}