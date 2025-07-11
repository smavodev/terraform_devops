#!/bin/bash

set -e  # 🔒 Salir si hay errores
set -u  # ❗ Error si usamos variables sin definir

echo "📦 [1/7] Actualizando lista de paquetes..."
sudo apt update

echo "📥 [2/7] Instalando paquetes requeridos: ca-certificates, curl, gnupg, lsb-release..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "📁 [3/7] Creando directorio para llaves GPG..."
sudo install -m 0755 -d /etc/apt/keyrings

echo "🔑 [4/7] Descargando y agregando la clave GPG de Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg \
    --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "📝 [5/7] Agregando el repositorio de Docker para Ubuntu..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 [6/7] Actualizando lista de paquetes nuevamente..."
sudo apt update

echo "🐳 [7/7] Instalando Docker Engine y herramientas relacionadas..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "👤 [8/8] Añadiendo al usuario vagrant al grupo docker..."
sudo usermod -aG docker vagrant

echo "✅ Docker instalado correctamente."
echo

echo "🔍 Verificando versión instalada:"
sudo docker --version

echo "🚦 Verificando estado del servicio Docker:"
sudo systemctl status docker --no-pager

echo "ℹ️  Para usar Docker sin sudo, ejecuta: exit y vuelve a entrar con 'vagrant ssh'."

