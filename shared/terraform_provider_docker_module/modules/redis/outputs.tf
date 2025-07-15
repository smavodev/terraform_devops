# output "container_name" {
#   value = docker_container.redis.name
# }
#
# output "ip_address" {
#   value = docker_container.redis.network_data[0].ip_address
# }

output "info" {
  description = "Datos del contenedor Redis"
  value = {
    container_name = docker_container.redis.name
    ip_address   = docker_container.redis.network_data[0].ip_address
  }
}