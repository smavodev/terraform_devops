output "container_name" {
  value = docker_container.nginx.name
}

output "ip_address" {
  value = docker_container.nginx.network_data[0].ip_address
}
