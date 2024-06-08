variable "vm_ram" {
  type = number
  default = 2048
}

variable "vm_cpu_cores" {
  type = number
  default = 2
}

variable "nodename" {
  type = string
}

variable "vm_disc_size" {
  type = number
  default = 20
  description = "VM Discsize in GB"
}

variable "vm_name_prefix" {
  type = string
  default = ""
}

variable "vm_name_postfix" {
  type = string
  default = ""
}

variable "vm_name" {
  type = string
}

variable "vm_net_gateway" {
  type = string
}

variable "vm_net_ip" {
  type = string
}

variable "vm_net_dns_servers" {
  type = list(string)
}

variable "vm_master_id" {
  type = number
  default = 8000
  description = "ID of the machine which should be cloned"
}

variable "ssh_public_key" {
  type = string
}
variable "vm_tags" {
  type = list(string)
  default = []
}
# variable "vm_ci_usrdata_fileid" {
#   type = string
#   default = ""
# }
