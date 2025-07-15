output "application_urls" {
  description = "URLs de acceso a la aplicación"
  sensitive   = true
  value = {
    nginx     = "http://localhost:${var.nginx_external_port}"
    postgres  = "postgresql://${var.database_user}:${var.database_password}@localhost:${var.postgres_external_port}/${var.database_name}"
    redis     = "redis://localhost:${var.redis_external_port}"
  }
}

# # 🌐 Outputs del módulo NETWORK
# output "network_name" {
#   description = "Nombre de la red Docker"
#   value       = module.network.network_name
# }
#
# output "driver" {
#   description = "Driver de red usado"
#   value       = module.network.driver
# }
#
# # 💾 Outputs del módulo VOLUMES
# output "postgres_volume_name" {
#   description = "Nombre del volumen de PostgreSQL"
#   value       = module.volumes.postgres_volume_name
# }
#
# output "redis_volume_name" {
#   description = "Nombre del volumen de Redis"
#   value       = module.volumes.redis_volume_name
# }
#
# # 🐘 Outputs del módulo POSTGRES
# output "postgres_container_name" {
#   value = module.postgres.name
# }
#
# output "postgres_ip" {
#   value = module.postgres.ip
# }
#
# # 🔁 Outputs del módulo REDIS
# output "redis_container_name" {
#   value = module.redis.name
# }
#
# output "redis_ip" {
#   value = module.redis.ip
# }
#
# # 🌐 Outputs del módulo NGINX
# output "nginx_container_name" {
#   value = module.nginx.container_name
# }
#
# output "nginx_ip" {
#   value = module.nginx.ip_address
# }

output "all_info" {
  value = {
    postgres = module.postgres.info
    redis    = module.redis.info
    nginx    = module.nginx.info
    network  = module.network.info
    volumes  = module.volumes.info
  }
}
