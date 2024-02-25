###cloud vars
/*
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
*/

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}
variable "vpc_web_name" {
  type        = string
  default     = "develop1"
  description = "VPC subnet name"
}

variable "vpc_db_name" {
  type        = string
  default     = "develop2"
  description = "VPC  subnet name"
}

###ssh vars
/*
variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}*/
###new vars
variable "vm_web_name" {
  type = string
  default = "netology-develop-platform-web"
}

variable "vm_web_image" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v2"
}

/*variable "vm_web_cores" {
  type = number
  default = 2
}

variable "vm_web_memory" {
  type = number
  default = 1
}

variable "vm_web_fract" {
  type = number
  default = 5
}*/

variable "vm_web_prmt" {
  type = bool
  default = true
}

variable "vm_web_nat" {
  type = bool
  default = true
}

/*variable "vm_web_sp" {
  type = bool
  default = true
}*/
variable "vms_resources" {
  default     = {
    web ={cores ="2",memory ="1",core_fraction ="5"},
    db = {cores ="2",memory ="2",core_fraction ="5"}
  }
}
variable "meta" {
  default = {ssh_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4jYXGZJCUTbp+lme1i71RiraiMK6Kmf1lVEE9IbrYu Pavel Chvanin",
    sp_e="1"
  }
}
