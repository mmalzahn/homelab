variable "pm_user" {
  type = string
  description = "User for the login in proxmox server"
}

variable "pm_pwd" {
  type = string
  sensitive = true
  description = "Userpassword for the login"
}
variable "pm_api_token_id" {
  type = string
  description = "API Token ID for the user"
}

variable "pm_api_token" {
  type = string
  sensitive = true
  description = "API Token for the user"
}

variable "pm_api_url" {
  type = string
  description = "URL to the proxmox api"
}

variable "pm_node" {
  type = string
  description = "Default Node for the deployment"
}

variable "storage" {
  type = string
}

variable "ssh_public_key" {
  type = string
}