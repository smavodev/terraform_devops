terraform {
  required_providers {
    docker = {
      source  = "calxus/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

module "network" {
  source = "./modules/network"
  network_name = "roxs-voting-network"
  providers = {
    docker = docker
  }
}

module "volumes" {
  source = "./modules/volumes"
  postgres_volume_name = "postgres_data"
  redis_volume_name    = "redis_data"
  providers = {
    docker = docker
  }
}

module "postgres" {
  source = "./modules/postgres"

  image          = "postgres:15-alpine"
  container_name = "roxs-postgres"
  database_name     = var.database_name
  database_user     = var.database_user
  database_password = var.database_password
  external_port     = var.postgres_external_port
#   volume_name       = module.volumes.postgres_volume_name
#   network_name      = module.network.network_name
  volume_name       = module.volumes.info.postgres_volume_name
  network_name      = module.network.info.network_name

  providers = {
    docker = docker
  }
}

module "redis" {
  source = "./modules/redis"

  image          = "redis:7-alpine"
  container_name = "roxs-redis"
  external_port  = var.redis_external_port
#   volume_name    = module.volumes.redis_volume_name
#   network_name   = module.network.network_name
  volume_name    = module.volumes.info.redis_volume_name
  network_name   = module.network.info.network_name

  providers = {
    docker = docker
  }
}

module "nginx" {
  source = "./modules/nginx"

  image               = "nginx:alpine"
  container_name      = "roxs-nginx"
  nginx_external_port = var.nginx_external_port
#   network_name        = module.network.network_name
  network_name        = module.network.info.network_name
  nginx_conf_path = "${path.module}/nginx.conf"

  depends_on = [
    module.postgres,
    module.redis
  ]

  providers = {
    docker = docker
  }
}
