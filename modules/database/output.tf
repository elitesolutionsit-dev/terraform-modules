
output "name" {
  value = data.azurerm_resource_group.rg.name
}

output "account_kind" {
  value = data.azurerm_storage_account.storageaccount.account_kind
}