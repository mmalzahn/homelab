resource "proxmox_virtual_environment_vm" "vm" {
  name      = "${var.vm_name_prefix}${var.vm_name}${var.vm_name_postfix}"
  node_name = var.nodename
  migrate = true
  tags = var.vm_tags
  audio_device {
    enabled = false
  }
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
    bridge = "srvNet"
    enabled = true
    model = "virtio"
  }
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

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.nodename

  source_raw {
    data = <<EOF
#cloud-config
packages:
  - qemu-guest-agent
apt_update: true
apt_upgrade: true
ntp:
  ntp_client: auto
  enabled: true
package_update: true
package_upgrade: true
users:
  - default
  - name: ubuntu
    groups:
      - sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ${var.ssh_public_key}
    sudo: ALL=(ALL) NOPASSWD:ALL
runcmd:
    - timedatectl set-timezone Europe/Berlin
    - systemctl enable qemu-guest-agent
    - systemctl start qemu-guest-agent
    - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "${var.vm_name}-cloud-config.yaml"
  }
}