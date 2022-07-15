variable "administrator_login_password" {
  type = string
}

variable "source_address_prefix" {
  type    = string
  default = "70.114.65.185/32"
}

variable "destination_address_prefix" {
  type    = string
  default = "VirtualNetwork"
}
variable "rtb" {
  type    = string
  default = "elite_rtb"
}

variable "dbRGname" {
  type    = string
  default = "db"
}