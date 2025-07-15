terraform {
  required_providers {
    docker = {
      source = "calxus/docker"
    }
  }
}

resource "docker_image" "nginx" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "nginx" {
  name    = var.container_name
  image   = var.image
  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.nginx_external_port
  }


  # Subir archivo nginx.conf al contenedor
#   upload {
#     content = <<EOT
#     events {}
#
#     http {
#       server {
#         listen 80;
#         location / {
#           return 200 '¡Nginx funcionando correctamente!';
#           add_header Content-Type text/plain;
#         }
#       }
#     }
#     EOT
#     file = "/etc/nginx/nginx.conf"
#   }

  upload {
    source = var.nginx_conf_path
    file   = "/etc/nginx/nginx.conf"
  }

  networks_advanced {
    name    = var.network_name
    aliases = ["proxy", "nginx"]
  }

  # Solo depende si se usan recursos directos fuera del módulo
  lifecycle {
    ignore_changes = [upload]  # Opcional si haces pruebas frecuentes
  }
}
