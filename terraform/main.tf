terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.yc_token 
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "jenkins" {
  name = "jenkins"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size        = 25
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-pr-8.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
  
}

resource "yandex_vpc_network" "network-pr-8" {
  name = "network-pr-8"
}

resource "yandex_vpc_subnet" "subnet-pr-8" {
  name           = "subnet-pr-8"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-pr-8.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_jenkins" {
  value = yandex_compute_instance.jenkins.network_interface.0.ip_address
}

output "external_ip_address_jenkins" {
  value = yandex_compute_instance.jenkins.network_interface.0.nat_ip_address
}

# generate inventory file for Ansible
resource "local_file" "inventory" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      jenkins = yandex_compute_instance.jenkins.network_interface.*.nat_ip_address
    }
  )
  filename = "../ansible/inventory.ini"
}      
