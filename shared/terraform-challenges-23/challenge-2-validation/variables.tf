variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "application_config" {
  type = object({
    name    = string
    features = object({
      monitoring = bool
      backup     = bool
    })
    runtime = object({
      memory = number
      cpu    = number
    })
  })
}
