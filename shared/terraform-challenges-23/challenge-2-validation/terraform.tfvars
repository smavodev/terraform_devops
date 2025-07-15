app_name   = "plataforma-x"
environment = "prod"
application_config = {
  name = "api-servicio"
  features = {
    monitoring = true
    backup     = true
  }
  runtime = {
    memory = 2048
    cpu    = 1
  }
}