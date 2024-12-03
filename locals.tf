
# Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata

locals {
  ssh_key_file = "${file("~/.ssh/id_ed25519.pub")}"
}

locals {
  instance_list = {
    web = [for instance in yandex_compute_instance.web : {
      name = instance.name
      ip   = instance.network_interface[0].nat_ip_address
      fqdn = instance.fqdn
    }]
    db = [for instance in yandex_compute_instance.db : {
      name = instance.name
      ip   = instance.network_interface[0].nat_ip_address
      fqdn = instance.fqdn
    }]
    storage = [for instance in [yandex_compute_instance.storage] : {
      name = instance.name
      ip   = instance.network_interface[0].nat_ip_address
      fqdn = instance.fqdn
    }]
  }
}

### По заданию 7

locals {
  vpc = {
    "network_id" = "enp7i560tb28nageq0cc"
    "subnet_ids" = [
      "e9b0le401619ngf4h68n",
      "e2lbar6u8b2ftd7f5hia",
      "b0ca48coorjjq93u36pl",
      "fl8ner8rjsio6rcpcf0h",
    ]
    "subnet_zones" = [
      "ru-central1-a",
      "ru-central1-b",
      "ru-central1-c",
      "ru-central1-d",
    ]
  }
}
