variable "backend_http_settings" {
  type = list(object({
    name                  = string
    path                  = string
    request_timeout       = string
    cookie_based_affinity = string
  }))
}

variable "http_listener" {
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
  }))
}

variable "request_routing_rule" {
  type = list(object({

    name                       = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = string
  }))
}

variable "sku_tier" {
  description = "Tier of App Gateway SKU. Options include Standard, Standard_v2, WAF and WAF_v2"
  default     = "WAF_v2"
}