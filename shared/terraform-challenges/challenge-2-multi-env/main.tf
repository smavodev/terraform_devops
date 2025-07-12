resource "local_file" "environment_configs" {
  for_each = var.environments

  filename = "outputs/${each.key}.tf"
  content  = templatefile("${path.module}/templates/environment.tpl", {
    env_name = each.key
    config   = each.value
  })
}
