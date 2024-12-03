### По заданию 5

output "web_and_db_list" {
  value = [
    [
      for instance in yandex_compute_instance.web : {
      name = instance.name
      id   = instance.id
      fqdn = instance.fqdn
      }
    ],
    [
      for instance in yandex_compute_instance.db : {
      name = instance.name
      id   = instance.id
      fqdn = instance.fqdn
      }
    ]
  ]
}

### По заданию 7

output "vpc_info" {
  value = { for key, value in local.vpc :
    key => can(tolist(value)) ? [for i in value : i if index(value, i) != 2] : value
  }
}