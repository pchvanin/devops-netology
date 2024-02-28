resource "yandex_compute_disk" "storage" {
  count = 3
  size = 1
  type = "network-ssd"
  zone = "ru-central1-a"
}


resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_instance.WM-fore_each]
  platform_id = var.DZ_platform_id
  name = "storage"

  resources {
    cores         = var.disk_resources.disk_vm_cores
    memory        = var.disk_resources.disk_vm_memory
    core_fraction = var.disk_resources.disk_vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = 10
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_key}"
  }

  dynamic "secondary_disk"  {
    for_each =  yandex_compute_disk.storage
    content {
      disk_id = secondary_disk.value.id
    }
  }
}