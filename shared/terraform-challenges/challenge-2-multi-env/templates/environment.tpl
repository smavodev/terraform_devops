# Configuración para el entorno ${env_name}

provider "aws" {
  region = "${config.region}"
}

resource "aws_instance" "${env_name}" {
  count         = ${config.instance_count}
  instance_type = "${config.instance_type}"
  ami           = "ami-12345678"

  tags = {
    Name = "${env_name}-instance"
  }
}

resource "aws_db_instance" "${env_name}_db" {
  instance_class         = "db.${config.instance_type}"
  allocated_storage      = "${config.database_size == "small" ? 20 : config.database_size == "medium" ? 50 : 100}"
  engine                 = "mysql"
  username               = "admin"
  password               = "secret"
  skip_final_snapshot    = true

  backup_retention_period = "${config.backup_enabled ? 7 : 0}"
}
