##!/bin/bash

set -e  # 🔒 Salir si hay errores
set -u  # ❗ Error si usamos variables sin definir

# Funciones para mensajes con íconos
info()    { echo -e "$1"; }
warn()    { echo -e "⚠️  $1"; }
success() { echo -e "✅ $1"; }

# 1. Obtener el codename de Ubuntu (ej. jammy, focal)
info "🔍 [1/5] Detectando nombre de versión de Ubuntu..."
UBUNTU_CODENAME=$(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs)

if [[ -z "$UBUNTU_CODENAME" ]]; then
  warn "No se pudo detectar el nombre de la versión de Ubuntu. Verifica tu sistema."
  exit 1
fi

info "📦 Ubuntu Codename detectado: $UBUNTU_CODENAME"

# 2. Agregar clave GPG de HashiCorp
info "🔐 [2/5] Agregando clave GPG de HashiCorp..."
sudo mkdir -p /usr/share/keyrings
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 3. Agregar repositorio oficial de HashiCorp
info "📝 [3/5] Agregando repositorio de HashiCorp a APT..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $UBUNTU_CODENAME main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# 4. Actualizar e instalar Terraform
info "🔄 [4/5] Actualizando lista de paquetes e instalando Terraform..."
sudo apt update
sudo apt install -y terraform

# 5. Verificar instalación
info "🔍 [5/5] Verificando instalación de Terraform..."
terraform -version

success "🎉 Terraform se ha instalado correctamente."

