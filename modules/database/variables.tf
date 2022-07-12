#-------------------- optional variables #
variable "dbRGname" {
  type = string
}

variable "server" {
  type = string
}

variable "buildregion" {
  type = string
}
variable "storageaccount" {
  type = string
}

variable "sqlserver" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_login_password" {
  type = string
}

variable "fwRulename" {
  type = string
}

variable "start_ip_address" {
  type = string
}

variable "end_ip_address" {
  type = string
}

variable "dbname" {
  type = string
}

#-------------------- required variables #
variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "versionsql" {
  type    = string
  default = "12.0"
}

variable "collation" {
  type    = string
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  type    = string
  default = "LicenseIncluded"
}

variable "read_scale" {
  type    = bool
  default = false
}

variable "zone_redundant" {
  type    = bool
  default = true
}