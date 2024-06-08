module "mastermachines" {
source = "./module/vm"
count = 3
vm_name = "master${count.index + 1}"
nodename = var.pm_node
vm_net_ip = "10.123.100.${100 + count.index + 1}/24"
vm_net_gateway = "10.123.100.1"
vm_net_dns_servers = ["10.123.100.1"]
vm_ci_usrdata_fileid = proxmox_virtual_environment_file.cloud_config.id
}

output "testout" {
  value = module.mastermachines[*].vm
}