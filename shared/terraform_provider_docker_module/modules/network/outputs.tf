output "network_name" {
  value = docker_network.app_network.name
}

output "driver" {
  value = docker_network.app_network.driver
}
