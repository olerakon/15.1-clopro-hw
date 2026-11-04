data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

# Public VM — bastion для доступа к private VM.
resource "yandex_compute_instance" "public_vm" {
  name        = "public-vm"
  hostname    = "public-vm"
  description = "Bastion VM in the public subnet"
  zone        = var.default_zone
  platform_id = var.vm_platform_id
  labels      = var.labels

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = var.vm_disk_type
      size     = var.vm_disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      vm_user        = var.vm_user
      ssh_public_key = file(var.public_key_path)
    })
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }
}

# Private VM без публичного IP.
# Интернет доступен только через NAT-инстанс
resource "yandex_compute_instance" "private_vm" {
  name        = "private-vm"
  hostname    = "private-vm"
  description = "Private VM with internet access through NAT"
  zone        = var.default_zone
  platform_id = var.vm_platform_id
  labels      = var.labels

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      # HDD-диск для private VM.
      image_id = data.yandex_compute_image.ubuntu.id
      type     = var.vm_disk_type
      size     = var.vm_disk_size
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.private.id
    ip_address = var.private_vm_ip
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      vm_user        = var.vm_user
      ssh_public_key = file(var.public_key_path)
    })
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }
}