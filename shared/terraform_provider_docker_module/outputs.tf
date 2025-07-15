output "application_urls" {
  description = "URLs de acceso a la aplicación"
  sensitive   = true
  value = {
    nginx     = "http://localhost:${var.nginx_external_port}"
    postgres  = "postgresql://${var.database_user}:${var.database_password}@localhost:${var.postgres_external_port}/${var.database_name}"
    redis     = "redis://localhost:${var.redis_external_port}"
  }
}