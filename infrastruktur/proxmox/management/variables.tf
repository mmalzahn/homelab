variable "pm_api_token_id" {
  type        = string
  description = "API Token ID for the user"
}

variable "pm_api_url" {
  type        = string
  description = "URL to the proxmox api"
}

variable "pm_node" {
  default     = "nuc1"
  type        = string
  description = "Default Node for the deployment"
}

variable "storage" {
  type = string
}

variable "ssh_public_key" {
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

variable "ssh_private_key_file" {
  type = string
}
