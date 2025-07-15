resource "local_file" "service_configs" {
  for_each = local.service_configs

  filename = "services/${each.key}-config.yaml"

  content = templatefile("${path.module}/templates/service.yaml.tpl", {
    service       = each.value
    global_config = {
      app_name    = var.app_name
      environment = var.environment
      tags        = local.common_tags
    }
  })
}