
### По заданию 4

# Исправление ошибки №2

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tpl",
   {webservers =  yandex_compute_instance.web
    databases = yandex_compute_instance.db
    storage = [yandex_compute_instance.storage]
    }
  )
  filename = "${abspath(path.module)}/hosts.cfg"
}
