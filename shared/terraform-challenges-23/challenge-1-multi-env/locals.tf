locals {
  environment_configs = {
    for env, config in var.environments :
    env => merge(config, {
      storage_size    = env == "prod" ? 100 : env == "staging" ? 50 : 20
      cdn_enabled     = env == "prod"
      waf_enabled     = env == "prod"
      resource_prefix = "${var.app_name}-${env}"
      monthly_cost = config.min_replicas * lookup({
        "t3.micro"  = 8.5,
        "t3.small"  = 17.0,
        "t3.medium" = 34.0
      }, config.instance_type, 25.0)
    })
  }
}

output "generated_configs" {
  value = local.environment_configs
}