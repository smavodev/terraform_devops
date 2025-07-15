output "postgres_volume_name" {
  value = docker_volume.postgres.name
}

output "redis_volume_name" {
  value = docker_volume.redis.name
}
