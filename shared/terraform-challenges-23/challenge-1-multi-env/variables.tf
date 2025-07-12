variable "app_name" {
  type = string
  default = "mi-aplicacion"
}

variable "environments" {
  type = map(object({
    instance_type     = string
    min_replicas      = number
    max_replicas      = number
    enable_monitoring = bool
    backup_retention  = number
    ssl_required      = bool
  }))
}
