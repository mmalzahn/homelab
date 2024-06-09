variable "nodename" {
  type = string
}

variable "vm_name_prefix" {
  type    = string
  default = ""
}

variable "vm_name_postfix" {
  type    = string
  default = ""
}

variable "lxc_config" {
  type = object({
    name                     = string
    disc_size                = number
    cpu_cores                = number
    ram                      = number
    net_bridge               = string
    net_ip                   = string
    net_gw                   = string
    net_dns_servers          = list(string)
    net_name                 = string
    net_fw                   = bool
    pool_id                  = string
    tags                     = list(string)
    ssh_public_key           = string
    ssh_private_key          = string
    operating_system         = string
    operating_system_version = string
    unprivileged             = bool
    nesting                  = bool
  })
}
