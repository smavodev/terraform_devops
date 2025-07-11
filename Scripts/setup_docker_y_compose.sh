#!/bin/bash

set -e  # 🔒 Salir si hay errores
set -u  # ❗ Error si usamos variables sin definir

# Función para mostrar mensajes con íconos
info()    { echo -e "$1"; }
warn()    { echo -e "⚠️  $1"; }
success() { echo -e "✅ $1"; }

# 1. Verificar versión de Ubuntu
UBUNTU_VERSION=$(lsb_release -rs)
info "🔎 [1/10] Verificando versión de Ubuntu: $UBUNTU_VERSION"

if [[ "$UBUNTU_VERSION" < "20.04" ]]; then
  warn "Tu versión de Ubuntu ($UBUNTU_VERSION) es antigua. Se recomienda Ubuntu 20.04 o superior para usar Docker Compose v2 correctamente."
  warn "Puedes continuar, pero podrías tener problemas de compatibilidad."
fi

# 2. Eliminar Docker antiguo
info "🧹 [2/10] Eliminando versiones antiguas de Docker (si existen)..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# 3. Instalar dependencias
info "📦 [3/10] Instalando dependencias necesarias (curl, gnupg, ca-certificates...)"
sudo apt-get update
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  apt-transport-https \
  software-properties-common

# 4. Agregar clave GPG de Docker
info "🔐 [4/10] Agregando clave GPG oficial de Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 5. Agregar repositorio de Docker
info "📝 [5/10] Agregando repositorio oficial de Docker al sistema..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 6. Actualizar paquetes
info "🔄 [6/10] Actualizando lista de paquetes..."
sudo apt-get update

# 7. Instalar Docker y Compose
info "🐳 [7/10] Instalando Docker Engine, CLI, Buildx y Compose v2 plugin..."
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# 8. Verificar instalación
info "🔍 [8/10] Verificando versiones instaladas:"
docker --version
docker compose version

# 9. Agregar usuario al grupo docker
info "👤 [9/10] Agregando el usuario '$USER' al grupo 'docker'..."
sudo usermod -aG docker $USER

# 10. Finalizar
success "🎉 [10/10] Docker y Docker Compose se instalaron correctamente."
warn "⚠️  Cierra sesión y vuelve a iniciar, o ejecuta 'newgrp docker' para aplicar los cambios de grupo."
