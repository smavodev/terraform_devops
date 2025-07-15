variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "voting_app"
}

variable "database_user" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "postgres"
}

variable "database_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
  default     = "postgres123"
}

variable "postgres_external_port" {
  type    = number
  default = 5432
}

variable "redis_external_port" {
  type    = number
  default = 6379
}

variable "nginx_external_port" {
  type    = number
  default = 8080
}
