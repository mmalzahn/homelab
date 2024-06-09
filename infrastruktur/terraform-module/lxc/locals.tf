locals {
  images = {
    ubuntu = {
      22.04="ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
      23.10="ubuntu-23.10-standard_23.10-1_amd64.tar.zst"
      24.04="ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    }
    alpine ={
      3.19="alpine-3.19-default_20240207_amd64.tar.xz"
    }
    debian={
      12="debian-12-standard_12.2-1_amd64.tar.zst"
    }
  }
}