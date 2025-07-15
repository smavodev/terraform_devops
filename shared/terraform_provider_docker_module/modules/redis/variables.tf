variable "container_name" {
  description = "Nombre del contenedor Redis"
  type        = string
}

variable "image" {
  type = string
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
