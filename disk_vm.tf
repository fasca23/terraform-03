### По заданию 3

resource "yandex_compute_disk" "storage_disk" {
  count    = 3
  name     = "storage-disk-${count.index}"
  type     = "network-hdd"
  size     = 1
  zone     = var.default_zone  
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage-resource[0].vm_name
  platform_id = var.storage-resource[0].platform_id
  zone        = var.default_zone

  resources {
    cores  = var.storage-resource[0].cores
    memory = var.storage-resource[0].memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.storage-resource[0].preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.storage-resource[0].nat
  }
  depends_on = [yandex_compute_disk.storage_disk]

  metadata = {
    ssh-keys = local.ssh_key_file
  }
 
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk.*.id
    content {
      disk_id = secondary_disk.value
    }
  }
}