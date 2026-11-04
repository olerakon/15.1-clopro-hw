variable "sa_key_file" {
  type        = string
  description = "Path to the Yandex Cloud service account key file"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud folder ID"
}

variable "default_zone" {
  type        = string
  description = "Default Yandex Cloud availability zone"
  default     = "ru-central1-a"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "netology-vpc"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet"
  default     = "public"
}

variable "private_subnet_name" {
  type        = string
  description = "Name of the private subnet"
  default     = "private"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
  default     = "192.168.10.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
  default     = "192.168.20.0/24"
}

variable "nat_instance_ip" {
  type        = string
  description = "Static internal IP address of the NAT instance"
  default     = "192.168.10.254"
}

variable "private_vm_ip" {
  type        = string
  description = "Static internal IP address of the private VM"
  default     = "192.168.20.10"
}

variable "nat_image_id" {
  type        = string
  description = "Prepared image for NAT-instance Yandex Cloud"
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_platform_id" {
  type        = string
  description = "Yandex Compute Cloud platform ID"
  default     = "standard-v3"
}

variable "vm_cores" {
  type        = number
  description = "Number of vCPUs for each VM"
  default     = 2
}

variable "vm_memory" {
  type        = number
  description = "Memory size for each VM, GB"
  default     = 2
}

variable "vm_core_fraction" {
  type        = number
  description = "Baseline CPU performance percentage"
  default     = 20
}

variable "vm_disk_size" {
  type        = number
  description = "Boot disk size for each VM, GB"
  default     = 10
}

variable "vm_preemptible" {
  type        = bool
  description = "Create preemptible VMs"
  default     = true
}

variable "vm_user" {
  type        = string
  description = "Username created by cloud-init"
  default     = "ubuntu"
}

variable "public_key_path" {
  type        = string
  description = "Path to the SSH public key file"
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to created resources"
  default = {
    project = "netology"
    hw      = "clopro-15.1"
  }
}

variable "nat_disk_type" {
  type        = string
  description = "Boot disk type for the NAT instance"
  default     = "network-ssd"
}

variable "nat_disk_size" {
  type        = number
  description = "Boot disk size for the NAT instance, GB"
  default     = 10
}

variable "vm_disk_type" {
  type        = string
  description = "Boot disk type for Ubuntu VMs"
  default     = "network-hdd"
}