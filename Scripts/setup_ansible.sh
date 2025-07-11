#!/bin/bash

set -e  # 🔒 Salir si ocurre un error
set -u  # ❗ Error si se usan variables no definidas

# Funciones para mensajes con íconos
info()    { echo -e "$1"; }
warn()    { echo -e "⚠️  $1"; }
success() { echo -e "✅ $1"; }

# Validar argumentos
if [ "$#" -ne 2 ]; then
  warn "Uso: $0 <usuario_ansible> <ip_vm>"
  exit 1
fi

# Variables
ANSIBLE_USER="$1"
IP_VM="$2"
IP_LOCAL="localhost"
USER_LOCAL="local"
ANSIBLE_HOST_FILE="/etc/ansible/hosts"
SSH_KEY_PATH="/home/${ANSIBLE_USER}/.ssh/id_rsa"

# 1. Instalar Ansible
info "🔄 [1/6] Instalando dependencias y Ansible..."
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
success "Ansible instalado correctamente"

# 2. Validar archivo de hosts
info "📁 [2/6] Verificando archivo de configuración de hosts..."
if [ ! -f "$ANSIBLE_HOST_FILE" ]; then
  warn "❌ Archivo $ANSIBLE_HOST_FILE no encontrado"
  exit 1
fi

# 3. Limpiar sección anterior de [webservers]
info "🧹 [3/6] Limpiando entradas anteriores de [webservers] (si existían)..."
sudo sed -i '/^\[webservers\]/,/^\[.*\]/d' "$ANSIBLE_HOST_FILE"

# 4. Agregar nueva sección [webservers]
info "📝 [4/6] Agregando nueva sección [webservers] al archivo de hosts..."
cat <<EOF | sudo tee -a "$ANSIBLE_HOST_FILE"
[webservers]
$IP_LOCAL ansible_connection=$USER_LOCAL
EOF



# CASO NORMAL
# [webservers]
# $IP_VM ansible_user=$ANSIBLE_USER ansible_ssh_private_key_file=$SSH_KEY_PATH

# POR SI FALLA LA AUTENTICACION POR SSH
# [webservers]
# $IP_LOCAL ansible_user=$USER_LOCAL

# 5. Probar conexión con Ansible
info "📡 [5/6] Probando conexión con Ansible (ping)..."
ansible webservers -m ping -i "$ANSIBLE_HOST_FILE"

# Primer ping para aceptar clave y validar acceso - CASO NORMAL
# ansible all -m ping -i "$ANSIBLE_HOST_FILE" -u "$ANSIBLE_USER" --private-key "$SSH_KEY_PATH"
#ansible webservers -m ping -i "$ANSIBLE_HOST_FILE"

# 6. Confirmar éxito
success "🎉 [6/6] Configuración completada. Ansible puede conectarse correctamente."
