service:
  name: ${service.name}
  url: ${service.internal_url}
  resources:
    cpu: ${service.resources.cpu}
    memory: ${service.resources.memory}
  health_check:
    path: ${service.health_check.path}
    port: ${service.health_check.port}
  environment:
%{ for key, val in service.environment_vars ~}
    ${key}: ${val}
%{ endfor ~}

meta:
  app: ${global_config.app_name}
  env: ${global_config.environment}
  tags:
%{ for tag, value in global_config.tags ~}
    ${tag}: ${value}
%{ endfor ~}
