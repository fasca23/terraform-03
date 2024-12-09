### По заданию 5

# Исправление ошибки №3
output "web_and_db_list" {
  value = flatten([
    [for i in yandex_compute_instance.web : {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }],
    [for i in [yandex_compute_instance.storage] : {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }]
  ])
}

### По заданию 7

output "vpc_info" {
  value = { for key, value in local.vpc :
    key => can(tolist(value)) ? [for i in value : i if index(value, i) != 2] : value
  }
}