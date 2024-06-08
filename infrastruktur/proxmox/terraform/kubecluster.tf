locals {
  vm_name = "testserver1"
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.pm_node

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

    file_name = "cloud-config.yaml"
  }
}
# resource "proxmox_virtual_environment_file" "cloud_config" {
#   content_type = "snippets"
#   datastore_id = "local"
#   node_name    = var.pm_node

#   source_raw {
#     data = <<EOF
# #cloud-config
# users:
#   - default
#   - name: ubuntu
#     groups:
#       - sudo
#     shell: /bin/bash
#     ssh_authorized_keys:
#       - ${var.ssh_public_key}
#     sudo: ALL=(ALL) NOPASSWD:ALL
# runcmd:
#     - apt update
#     - apt install -y qemu-guest-agent net-tools
#     - timedatectl set-timezone Europe/Berlin
#     - systemctl enable qemu-guest-agent
#     - systemctl start qemu-guest-agent
#     - echo "done" > /tmp/cloud-config.done
#     EOF

#     file_name = "cloud-config.yaml"
#   }
# }
