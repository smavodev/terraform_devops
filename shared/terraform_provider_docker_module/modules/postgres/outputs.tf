output "name" {
  value = docker_container.postgres.name
}

output "ip" {
  value = docker_container.postgres.network_data[0].ip_address
}
