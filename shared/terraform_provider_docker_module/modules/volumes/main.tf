terraform {
  required_providers {
    docker = {
      source = "calxus/docker"
    }
  }
}

resource "docker_volume" "postgres" {
  name = var.postgres_volume_name
}

resource "docker_volume" "redis" {
  name = var.redis_volume_name
}
