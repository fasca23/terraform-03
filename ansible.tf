
### По заданию 4

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tpl",{
    webservers = local.instance_list["web"]
    databases  = local.instance_list["db"]
    storage    = local.instance_list["storage"]
  })
  filename = "${abspath(path.module)}/hosts.cfg"

  depends_on = [yandex_compute_instance.web,yandex_compute_instance.db,yandex_compute_instance.storage]
}