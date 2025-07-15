# output "network_name" {
#   value = docker_network.app_network.name
# }
#
# output "driver" {
#   value = docker_network.app_network.driver
# }

output "info" {
  description = "Datos de la red"
  value = {
    network_name   = docker_network.app_network.name
    driver = docker_network.app_network.driver
  }
}
