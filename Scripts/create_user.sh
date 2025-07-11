#!/bin/bash

set -e  # 🔒 Salir si hay errores
set -u  # ❗ Error si usamos variables sin definir

USUARIO="$1"
CONTRASENA="1nd1.sm4rt%%"
DIR_HOME="/home/$USUARIO"
DIR_CLAVE="$DIR_HOME/.ssh"
ARCHIVO_ID_RSA="$DIR_CLAVE/id_rsa"
ARCHIVO_PUB="$DIR_CLAVE/id_rsa.pub"
CARPETA_SYNC="$2"
IP_VM="$3"

echo "✅ Creando usuario: $USUARIO"
if id "$USUARIO" &>/dev/null; then
  echo "🔁 El usuario $USUARIO ya existe."
else
  useradd -m -s /bin/bash "$USUARIO"
  echo "$USUARIO:$CONTRASENA" | chpasswd
  usermod -aG sudo "$USUARIO"
  echo "$USUARIO ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USUARIO
  chmod 440 /etc/sudoers.d/$USUARIO
fi

# 🧱 Crear carpeta .ssh si no existe
echo "📁 Asegurando estructura SSH..."
mkdir -p "$DIR_CLAVE"
chown "$USUARIO:$USUARIO" "$DIR_CLAVE"
chmod 700 "$DIR_CLAVE"

# 🧹 Eliminar claves anteriores
rm -f "$ARCHIVO_ID_RSA" "$ARCHIVO_PUB" "$CARPETA_SYNC/id_rsa"

# 🔐 Generar claves SSH como el usuario correcto
echo "🔐 Generando clave SSH..."
sudo -u "$USUARIO" ssh-keygen -t rsa -b 4096 -f "$ARCHIVO_ID_RSA" -N ""

# ✅ Copiar clave pública a authorized_keys
echo "📋 Configurando authorized_keys..."
cat "$ARCHIVO_PUB" > "$DIR_CLAVE/authorized_keys"
chown "$USUARIO:$USUARIO" "$DIR_CLAVE/authorized_keys"
chmod 600 "$DIR_CLAVE/authorized_keys"

# 💾 Copiar clave privada al host para Vagrant
echo "📁 Copiando clave privada a carpeta compartida..."
cp "$ARCHIVO_ID_RSA" "$CARPETA_SYNC/id_rsa"
chmod 600 "$CARPETA_SYNC/id_rsa"
chown vagrant:vagrant "$CARPETA_SYNC/id_rsa"

# 🚫 Deshabilitar al usuario vagrant de forma segura (opcional)
if id "vagrant" &>/dev/null; then
  echo "🔒 Deshabilitando acceso de usuario vagrant..."
  usermod -L vagrant
  usermod -s /usr/sbin/nologin vagrant
fi

echo "✅ Usuario $USUARIO creado y configurado."
echo "👉 Puedes conectarte con: ssh -i ./shared/id_rsa $USUARIO@$IP_VM"
