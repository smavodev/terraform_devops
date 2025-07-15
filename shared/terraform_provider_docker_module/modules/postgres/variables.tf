variable "container_name" {
  description = "Nombre del contenedor PostgreSQL"
  type        = string
}

variable "image" {
  type = string
}

variable "database_name" {
  type = string
}

variable "database_user" {
  type = string
}

variable "database_password" {
  type      = string
  sensitive = true
}

variable "external_port" {
  type = number
}

variable "volume_name" {
  type = string
}

variable "network_name" {
  type = string
}
