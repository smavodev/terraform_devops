app_name   = "mi-app"
environment = "dev"

microservices = {
  users = {
    port         = 3000
    language     = "nodejs"
    memory_mb    = 256
    replicas     = 2
    dependencies = ["auth"]
  }
  auth = {
    port         = 4000
    language     = "python"
    memory_mb    = 128
    replicas     = 1
    dependencies = []
  }
}