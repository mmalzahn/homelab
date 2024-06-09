resource "proxmox_virtual_environment_vm" "vm" {
  name      = "${var.vm_name_prefix}${var.vm_name}${var.vm_name_postfix}"
  node_name = var.nodename
  migrate = true
  tags = var.vm_tags
  # audio_device {
  #   enabled = false
  # }
  cpu {
    type  = "host"
    cores = var.vm_cpu_cores
  }
  disk {
    interface = "scsi0"
    size      = var.vm_disc_size
    discard   = "on"
    ssd       = true
  }
  memory {
    dedicated = var.vm_ram
    floating  = 1024
  }
  operating_system {
    type = "l26"
  }
  stop_on_destroy = true
  agent {
    enabled = true
    trim    = true
  }
  clone {
    vm_id = var.vm_master_id
    full  = true
  }
  network_device {
    bridge = var.vm_net_bridge
    enabled = true
    model = "virtio"
    firewall = false
  }
 pool_id = var.vm_pool_id
  initialization {
    ip_config {
      ipv4 {
        address = var.vm_net_ip
        gateway = var.vm_net_gateway
      }
    }
    dns {
      servers = var.vm_net_dns_servers
    }
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  lifecycle {
    ignore_changes = [initialization]
  }
}
data "template_file" "cloud_config" {
  template = file("${path.module}/cloud-config.tftpl")
  vars = {
    ssh_public_key = var.ssh_public_key
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.nodename
  overwrite = true

  source_raw {
    data = data.template_file.cloud_config.rendered
    file_name = "${var.vm_name}-cloud-config.yaml"
  }
}