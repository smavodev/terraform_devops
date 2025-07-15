locals {
  common_tags = {
    app        = var.app_name
    env        = var.environment
    managed_by = "terraform"
  }

  service_configs = {
    for service_name, config in var.microservices :
    service_name => {
      name         = service_name
      internal_url = "http://${service_name}:${config.port}"

      resources = {
        cpu = (
          config.language == "java"   ? "500m" :
          config.language == "python" ? "200m" :
          "100m"
        )
        memory = "${config.memory_mb}Mi"
      }

      health_check = {
        path = (
          config.language == "java"   ? "/actuator/health" :
          config.language == "nodejs" ? "/health" :
          "/healthz"
        )
        port = config.port
      }

      environment_vars = merge(
        {
          SERVICE_NAME = service_name
          SERVICE_PORT = tostring(config.port)
          ENVIRONMENT  = var.environment
        },
        {
          for dep in config.dependencies :
          "${upper(dep)}_URL" => "http://${dep}:${var.microservices[dep].port}"
        }
      )
    }
  }
}