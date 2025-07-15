
environments = {
  dev = {
    instance_type     = "t3.micro"
    min_replicas      = 1
    max_replicas      = 2
    enable_monitoring = false
    backup_retention  = 7
    ssl_required      = false
  }
  staging = {
    instance_type     = "t3.small"
    min_replicas      = 2
    max_replicas      = 3
    enable_monitoring = true
    backup_retention  = 14
    ssl_required      = true
  }
  prod = {
    instance_type     = "t3.medium"
    min_replicas      = 4
    max_replicas      = 6
    enable_monitoring = true
    backup_retention  = 30
    ssl_required      = true
  }
}
