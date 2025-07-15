output "name" {
  value = docker_container.redis.name
}

output "ip" {
  value = docker_container.redis.network_data[0].ip_address
}
