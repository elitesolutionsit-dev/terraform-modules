data "azurerm_resource_group" "rgdb" {
  name = join("-", [local.server, var.dbRGname])
}

# data "azurerm_storage_account" "storageaccount" {
#   name                = join("", ["elitestorage"])
#   resource_group_name = join("-", [local.server, var.dbRGname])
# }
