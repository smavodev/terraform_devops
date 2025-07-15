terraform {
  required_providers {
    docker = {
      source = "calxus/docker"
    }
  }
}

resource "docker_image" "postgres" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "postgres" {
  name   = var.container_name
  image  = docker_image.postgres.name
  restart = "unless-stopped"

  env = [
    "POSTGRES_DB=${var.database_name}",
    "POSTGRES_USER=${var.database_user}",
    "POSTGRES_PASSWORD=${var.database_password}"
  ]

  ports {
    internal = 5432
    external = var.external_port
  }

  volumes {
    volume_name    = var.volume_name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["database", "postgres"]
  }

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.database_user}"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}
