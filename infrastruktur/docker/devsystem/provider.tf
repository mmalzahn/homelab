terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.58.1"
    }
  }
}

provider "proxmox" {
  # Configuration options
  api_token = var.pm_api_token_id
  endpoint = var.pm_api_url
  insecure = true
  ssh {
    agent = false
    private_key = file(var.ssh_private_key_file)
    username = "root"
  }
}