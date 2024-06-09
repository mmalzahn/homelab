locals {
  project_prefix = "infra-"
  lxc_defaults = {
    disc_size                = 10
    cpu_cores                = 2
    ram                      = 1024
    pool_id                  = "lab"
    operating_system         = "ubuntu"
    operating_system_version = "24.04"
    net_bridge               = "srvNet"
    net_gw                   = "10.123.100.1"
    net_dns_servers          = ["10.123.100.1"]
    net_name                 = "eth0"
    net_fw                   = false
    ssh_public_key           = var.ssh_public_key
    ssh_private_key          = file("~/.ssh/labkey")
    unprivileged             = true
    nesting                  = false
  }
  lxc_containers = [
    {
      name      = "docker-dev"
      disc_size = 60
      cpu_cores = 2
      ram       = 4096
      net_ip    = "10.123.100.30/24"
      nesting   = true
      tags      = ["management", "terraform", "infra", "managed", "dev"]
    },
    # {
    #   name      = "docker-prd"
    #   disc_size = 40
    #   cpu_cores = 4
    #   ram       = 4096
    #   net_ip    = "10.123.100.31/24"
    #   tags      = ["management", "terraform", "infra", "managed", "prd"]
    # }
  ]
  vms = [
    # {
    #   name       = "docker1"
    #   disc_size  = 40
    #   cpu_cores  = 4
    #   ram        = 8192
    #   net_bridge = "srvNet"
    #   net_ip     = "10.123.100.20/24"
    #   net_gw     = "10.123.100.1"
    #   pool_id    = "lab"
    #   tags       = ["management", "terraform"]
    # },
    # {
    #   name       = "docker2"
    #   disc_size  = 40
    #   cpu_cores  = 4
    #   ram        = 8192
    #   net_bridge = "srvNet"
    #   net_ip     = "10.123.100.21/24"
    #   net_gw     = "10.123.100.1"
    #   pool_id    = "lab"
    #   tags       = ["management", "terraform"]
    # }
  ]
}

locals {
  images = {
    ubuntu = {
      22.04 = "ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
      23.10 = "ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
      24.04 = "ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    }
    alpine = {
      3.19 = "alpine-3.19-default_20240207_amd64.tar.xz"
    }
    debian = {
      12 = "debian-12-standard_12.2-1_amd64.tar.zst"
    }
  }
}
