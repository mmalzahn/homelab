data "proxmox_virtual_environment_datastores" "datastores" {
  node_name = var.pm_node
}