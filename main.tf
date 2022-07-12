module "database" {

  source                       = "./modules/database/"
  dbRGname                     = join("-", ["elite", "database", "resources"])
  server                       = lower("ELITEDEV")
  buildregion                  = upper("eastus2")
  storageaccount               = join("-", ["elitestorage"])
  sqlserver                    = "sqladmin"
  administrator_login          = "sqladmin"
  dbname                       = "elitedevdb"
  fwRulename                   = "dbfwRule"
  start_ip_address             = "70.114.65.185"
  end_ip_address               = "70.114.65.185"
  administrator_login_password = var.administrator_login_password
}