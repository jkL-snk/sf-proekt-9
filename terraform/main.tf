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

# commented out to not max out on vpc network quota

#resource "yandex_vpc_network" "this" {
#  name = "default" 
#}

resource "yandex_vpc_subnet" "this" {
  name           = "sf-proekt-9"
  zone           = "ru-central1-a"
  network_id     = "enp1rcsgq9dhq3btkgj1" #yandex_vpc_network.this.id to use newly created network
  v4_cidr_blocks = ["192.168.10.0/24"]
}
resource "yandex_compute_instance" "worker" {
  
  name = "worker"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size        = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
  
}



output "internal_ip_address_worker" {
  value = yandex_compute_instance.worker.network_interface.0.ip_address
}

output "external_ip_address_worker" {
  value = yandex_compute_instance.worker.network_interface.0.nat_ip_address
}

# generate inventory file for Ansible
# add instances here
# modify hosts.tpl with variables from here
resource "local_file" "inventory" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      worker = yandex_compute_instance.worker.network_interface.*.nat_ip_address
    }
  )
  filename = "../ansible/inventory.ini"
}      
