terraform {
  required_providers {
        proxmox = {
      source = "bpg/proxmox"
      version = "0.58.1"
    }

    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
