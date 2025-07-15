variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "microservices" {
  type = map(object({
    port         = number
    language     = string
    memory_mb    = number
    replicas     = number
    dependencies = list(string)
  }))
}