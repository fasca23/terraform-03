### По заданию 2

resource "yandex_compute_instance" "web" {

# Исправление ошибки №1
#   4. ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2.
  depends_on = [yandex_compute_instance.db]

  count = 2
  name  = "web-${count.index + 1}"
  platform_id = var.vm_resource[0].platform
  resources {
    cores           = var.vm_resource[0].cores
    core_fraction   = var.vm_resource[0].core_fraction
    memory          = var.vm_resource[0].memory
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  # Назначьте ВМ созданную в первом задании группу безопасности.
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_resource[0].nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
# Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata
  metadata = {
    ssh-keys = local.ssh_key_file
  }


  scheduling_policy {
    preemptible = var.vm_resource[0].preemptible
  }
}