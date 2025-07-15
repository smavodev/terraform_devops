variable "image" {
  description = "Imagen Docker de NGINX"
  type        = string
}

variable "container_name" {
  description = "Nombre del contenedor NGINX"
  type        = string
}

variable "nginx_external_port" {
  description = "Puerto externo para NGINX"
  type        = number
}

variable "network_name" {
  description = "Nombre de la red Docker"
  type        = string
}

variable "nginx_conf_path" {
  description = "Ruta local del archivo nginx.conf"
  type        = string
}


variable "depends_on_containers" {
  description = "Lista de nombres de contenedores de los que depende NGINX"
  type        = list(string)
  default     = []
}
