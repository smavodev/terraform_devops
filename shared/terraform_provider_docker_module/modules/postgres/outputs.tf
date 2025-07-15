# output "container_name" {
#   value = docker_container.postgres.name
# }
#
# output "ip_address" {
#   value = docker_container.postgres.network_data[0].ip_address
# }

output "info" {
  description = "Datos del contenedor Postgres"
  value = {
    container_name = docker_container.postgres.name
    ip_address   = docker_container.postgres.network_data[0].ip_address
  }
}
