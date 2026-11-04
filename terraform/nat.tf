resource "yandex_compute_instance" "nat" {
  name        = "nat-instance"
  hostname    = "nat-instance"
  description = "NAT instance for private subnet outbound traffic"
  zone        = var.default_zone
  labels      = var.labels

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
      type     = var.nat_disk_type
      size     = var.nat_disk_size
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
    ip_address = var.nat_instance_ip
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml", {
      vm_user        = var.vm_user
      ssh_public_key = file(var.public_key_path)
    })
  }

  scheduling_policy {
    preemptible = false
  }
}