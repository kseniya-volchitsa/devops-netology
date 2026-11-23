packer {
  required_plugins {
    yandex = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/yandex"
    }
  }
}

variable "yc_token" {
  type      = string
  default   = env("YC_TOKEN")
  sensitive = true
}

source "yandex" "debian-docker" {
  token               = var.yc_token
  folder_id           = "b1gj0t5ngn83u02ifv9a"
  source_image_family = "debian-12"
  ssh_username        = "debian"
  ssh_timeout         = "10m"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
  subnet_id           = "e9b1rek336vko3k7cfuq"
  disk_type           = "network-hdd"
  disk_size_gb        = 10
  instance_name       = "packer-builder"
  image_name          = "debian-12-docker-htop-tmux"
}

build {
  sources = ["source.yandex.debian-docker"]

  provisioner "shell" {
    script = "install-docker.sh"
  }
}
