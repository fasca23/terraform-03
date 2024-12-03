###cloud vars

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
  description = "VPC network&subnet name"
}

### По заданию 2

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cores       = number
    memory      = number
    size        = number
    preemptible = bool
    nat         = bool
  }))
  default = [
    { 
      vm_name = "main", 
      cores = 4, 
      memory = 4,  
      size = 50, 
      preemptible = true, 
      nat = true 
    },
    { 
      vm_name = "replica", 
      cores = 2, 
      memory = 2,  
      size = 20,
      preemptible = true, 
      nat = true 
    },
  ]
}

variable "vm_resource" {
  type = list(object({
    cores         = number
    core_fraction = number
    memory        = number
    platform      = string
    preemptible   = bool
    nat           = bool
  }))
  default = [
    {
      cores         = 2
      core_fraction = 20
      memory        = 1
      platform      = "standard-v3"
      preemptible   = true
      nat           = true
    }
  ]
}

variable "storage-resource" {
    type = list(object({
      vm_name     = string
      platform_id = string
      cores       = number
      memory      = number
      preemptible = bool
      nat         = bool
  }))
    default = [
      { 
        vm_name     = "storage"
        platform_id = "standard-v3" 
        cores       = 2 
        memory      = 2   
        preemptible = true
        nat         = true  
      }
    ]
}