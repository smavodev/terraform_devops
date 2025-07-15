# output "postgres_volume_name" {
#   value = docker_volume.postgres.name
# }
#
# output "redis_volume_name" {
#   value = docker_volume.redis.name
# }

output "info" {
  description = "Datos de los volúmenes"
  value = {
    postgres_volume_name = docker_volume.postgres.name
    redis_volume_name    = docker_volume.redis.name
  }
}