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

# Crear directorio de outputs
mkdir -p /workspace/outputs

echo "📝 Exportando outputs de Terraform..."

# Guardar outputs en varios formatos
terraform output -json > /workspace/outputs/terraform-output.json
terraform output > /workspace/outputs/terraform-output.txt

# Opcional: generar archivos por cada variable de output individual
echo "📄 Generando archivos por variable..."
for var in $(terraform output -json | jq -r 'keys[]'); do
    terraform output "$var" > "/workspace/outputs/${var}.txt"
done

# Crear README
echo "📘 Generando README..."
cat <<EOF > /workspace/README.md
# Resultados del Despliegue Terraform

- Ambiente: $ENVIRONMENT
- Acción ejecutada: $ACTION
- Fecha: $(date)

## Archivos generados:
- terraform-output.json
- terraform-output.txt
- Archivos individuales por cada variable de output

EOF

echo "✅ ¡Proceso completado con éxito!"s