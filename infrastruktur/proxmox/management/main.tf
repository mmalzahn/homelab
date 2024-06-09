module "vms" {
  count              = length(local.vms)
  source             = "../../terraform-module/vm/"
  vm_name            = local.vms[count.index].name
  vm_disc_size       = local.vms[count.index].disc_size
  vm_name_prefix     = local.project_prefix
  vm_net_ip          = local.vms[count.index].net_ip
  vm_net_gateway     = local.vms[count.index].net_gw
  vm_net_bridge      = local.vms[count.index].net_bridge
  vm_net_dns_servers = [local.vms[count.index].net_gw]
  nodename           = var.pm_node
  vm_cpu_cores       = local.vms[count.index].cpu_cores
  vm_ram             = local.vms[count.index].ram
  ssh_public_key     = var.ssh_public_key
  vm_pool_id         = local.vms[count.index].pool_id
  vm_tags            = ["terraform", "infrastruktur"]
}

module "lxcs" {
  count          = length(local.lxc_containers)
  source         = "../../terraform-module/lxc"
  lxc_config     = merge(local.lxc_defaults, local.lxc_containers[count.index])
  nodename       = var.pm_node
  vm_name_prefix = local.project_prefix
}
output "test" {
  value = merge(local.lxc_defaults, local.lxc_containers[0])
}
