data "azurerm_resource_group" "rg" {
  name = join("-", [local.server, var.dbRGname])
}

data "azurerm_storage_account" "storageaccount" {
  name                = join("", [local.server, var.storageaccount])
  resource_group_name = join("-", [local.server, var.dbRGname])
}
