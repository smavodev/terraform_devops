terraform {
  required_providers {
    docker = {
      source = "calxus/docker"
    }
  }
}

resource "docker_image" "redis" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "redis" {
  name   = var.container_name
  image  = docker_image.redis.name
  restart = "unless-stopped"

  command = [
    "redis-server",
    "--appendonly", "yes",
    "--appendfsync", "everysec"
  ]

  ports {
    internal = 6379
    external = var.external_port
  }

  volumes {
    volume_name    = var.volume_name
    container_path = "/data"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["cache", "redis"]
  }

  healthcheck {
    test     = ["CMD", "redis-cli", "ping"]
    interval = "10s"
    timeout  = "3s"
    retries  = 3
  }
}
