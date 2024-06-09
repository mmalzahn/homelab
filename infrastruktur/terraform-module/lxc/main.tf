resource "proxmox_virtual_environment_container" "lxc" {
  node_name = var.nodename
  tags      = var.lxc_config.tags
  cpu {
    cores = var.lxc_config.cpu_cores
  }
  unprivileged = var.lxc_config.unprivileged
  memory {
    dedicated = var.lxc_config.ram
  }
  features {
    nesting = true
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user        = "root"
      host        = var.lxc_config.net_ip
      private_key = var.lxc_config.ssh_private_key
    }

    inline = [
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh",
    ]
  }
  disk {
    datastore_id = "local-lvm"
    size         = var.lxc_config.disc_size
  }
  network_interface {
    bridge   = var.lxc_config.net_bridge
    enabled  = true
    firewall = var.lxc_config.net_fw
    name     = var.lxc_config.net_name
  }
  console {
    enabled = true

  }
  pool_id = var.lxc_config.pool_id
  initialization {
    ip_config {
      ipv4 {
        address = var.lxc_config.net_ip
        gateway = var.lxc_config.net_gw
      }
    }
    dns {
      servers = var.lxc_config.net_dns_servers
    }
    #    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
    user_account {
      keys = [var.lxc_config.ssh_public_key]
    }
    hostname = "${var.vm_name_prefix}${var.lxc_config.name}${var.vm_name_postfix}"
  }
  operating_system {
    template_file_id = "local:vztmpl/${local.images[var.lxc_config.operating_system][var.lxc_config.operating_system_version]}"
    type             = var.lxc_config.operating_system
  }
  lifecycle {
    ignore_changes = [initialization]
  }
}
