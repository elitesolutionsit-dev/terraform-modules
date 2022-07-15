locals {
  network_tag = {
    Department  = "IT"
    Casecode    = "es20"
    ManagedWith = "Terraform"
    Owner       = "EliteInfra"
    Company     = "EliteSolutions LLC"
    Service     = "Elite Technology Services"
  }
  server              = "elite"
  buildregion         = "eastus2"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = "elite-vnetdevrg"
  subnet_names        = ["application", "database", "servers"]
  subnet_prefixes     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}