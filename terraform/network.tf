resource "yandex_vpc_network" "hw_network" {
  name        = var.vpc_name
  description = "VPC for the cloud providers homework"
  labels      = var.labels
}

resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet_name
  description    = "Public subnet with NAT instance and bastion VM"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw_network.id
  v4_cidr_blocks = [var.public_subnet_cidr]
  labels         = var.labels
}

resource "yandex_vpc_route_table" "private_route" {
  name        = "${var.private_subnet_name}-route"
  description = "Default route from private subnet through NAT instance"
  network_id  = yandex_vpc_network.hw_network.id
  labels      = var.labels

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_instance_ip
  }
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet_name
  description    = "Private subnet with outbound access through NAT"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw_network.id
  v4_cidr_blocks = [var.private_subnet_cidr]
  route_table_id = yandex_vpc_route_table.private_route.id
  labels         = var.labels
}