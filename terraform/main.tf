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
    subnet_id = yandex_vpc_subnet.subnet-12-web.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
  
}

resource "yandex_compute_instance" "worker-1" {
  name = "worker-1"

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
    subnet_id = yandex_vpc_subnet.subnet-12-web.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "worker-2" {
  name = "worker-2"

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
    subnet_id = yandex_vpc_subnet.subnet-12-web.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network12-web"
}

resource "yandex_vpc_subnet" "subnet-12-web" {
  name           = "subnet12web"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_jenkins" {
  value = yandex_compute_instance.jenkins.network_interface.0.ip_address
}

output "internal_ip_address_worker_1" {
  value = yandex_compute_instance.worker-1.network_interface.0.ip_address
}

output "internal_ip_address_worker_2" {
  value = yandex_compute_instance.worker-2.network_interface.0.ip_address
}


output "external_ip_address_jenkins" {
  value = yandex_compute_instance.jenkins.network_interface.0.nat_ip_address
}

output "external_ip_address_worker_1" {
  value = yandex_compute_instance.worker-1.network_interface.0.nat_ip_address
}

output "external_ip_address_worker_2" {
  value = yandex_compute_instance.worker-2.network_interface.0.nat_ip_address
}

# generate inventory file for Ansible
resource "local_file" "inventory" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      jenkins = yandex_compute_instance.jenkins.network_interface.*.nat_ip_address
      workers1 = yandex_compute_instance.worker-1.network_interface.*.nat_ip_address
      workers2 = yandex_compute_instance.worker-2.network_interface.*.nat_ip_address
    }
  )
  filename = "../ansible/inventory.ini"
}      