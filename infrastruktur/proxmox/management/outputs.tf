output "lxc" {
  value = module.lxcs.*.lxc
  sensitive = true
}

output "vms" {
  value = module.vms.*.vm
  sensitive = true
}