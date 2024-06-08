module "dockerhost" {
  source = "../../terraform-module/vm/"
  vm_name = "dev-docker"
  vm_disc_size = 40
  vm_name_prefix = "test"
  vm_net_ip = "10.123.100.120/24"
  vm_net_gateway = "10.123.100.1"
  vm_net_dns_servers = [ "10.123.100.1" ]
  nodename = var.pm_node
  vm_cpu_cores = 4
  vm_ram = 8192
  ssh_public_key = var.ssh_public_key
  vm_tags = [ "terraform","infrastruktur" ]
}