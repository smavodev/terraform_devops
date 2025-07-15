terraform {
  required_providers {
    docker = {
      source = "calxus/docker"
    }
  }
}

resource "docker_network" "app_network" {
  name = var.network_name
}
