#!/bin/bash

set -e  # 🔒 Salir si hay errores
set -u  # ❗ Error si usamos variables sin definir

ENVIRONMENT=${1:-terraform}
ACTION=${2:-plan}

echo "🚀 Terraform Deployment Script"
echo "🌍 Environment: $ENVIRONMENT"
echo "⚙️ Action: $ACTION"

if [[ ! "$ENVIRONMENT" =~ ^(terraform|dev|staging|prod)$ ]]; then
    echo "❌ Error: Entorno inválido (usa terraform, dev, staging o prod)"
    exit 1
fi

if [[ ! "$ACTION" =~ ^(plan|apply|destroy)$ ]]; then
    echo "❌ Error: Acción inválida (usa plan, apply o destroy)"
    exit 1
fi

export TF_VAR_environment=$ENVIRONMENT

cd /workspace

echo "📦 Inicializando Terraform..."
terraform init \
  -backend-config="key=environments/${ENVIRONMENT}/terraform.tfstate"

echo "✅ Validando configuración..."
terraform validate

echo "🚀 Ejecutando acción: $ACTION..."
case "$ACTION" in
  plan)
     terraform plan
#    terraform plan -var-file="environments/${ENVIRONMENT}.tfvars"
    ;;
  apply)
    terraform apply -auto-approve
#    terraform apply -var-file="environments/${ENVIRONMENT}.tfvars" -auto-approve
    ;;
  destroy)
    read -p "⚠️ ¿Estás seguro que deseas destruir $ENVIRONMENT? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
#      terraform destroy -var-file="environments/${ENVIRONMENT}.tfvars" -auto-approve
    terraform destroy -auto-approve
    else
      echo "❌ Cancelado."
      exit 1
    fi
    ;;
esac

echo "✅ ¡Proceso completado con éxito!"