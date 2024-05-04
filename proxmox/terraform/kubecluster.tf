locals {
  vm_name = "testserver1"
}

output "test" {
  value     = proxmox_virtual_environment_vm.master
  sensitive = true
}

resource "proxmox_virtual_environment_vm" "master" {
  name      = local.vm_name
  node_name = var.pm_node
  audio_device {
    enabled = false
  }
  cpu {
    type  = "host"
    cores = 2
  }
  disk {
    interface = "scsi0"
    size      = 20
    discard   = "on"
    ssd       = true
  }
  memory {
    dedicated = 4096
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
    vm_id = 8000
    full  = true
  }
  initialization {
    ip_config {
      ipv4 {
        address = "10.123.100.230/24"
        gateway = "10.123.100.1"
      }
    }
    dns {
      servers = ["10.123.100.1"]
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
  node_name    = var.pm_node

  source_raw {
    data = <<EOF
#cloud-config
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
    - apt update
    - apt install -y qemu-guest-agent net-tools
    - timedatectl set-timezone Europe/Berlin
    - systemctl enable qemu-guest-agent
    - systemctl start qemu-guest-agent
    - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}
