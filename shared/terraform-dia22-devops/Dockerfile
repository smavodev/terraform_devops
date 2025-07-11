# Dockerfile para ejecutar Terraform automáticamente con deploy.sh
FROM hashicorp/terraform:1.12.2

# Instalar herramientas adicionales
RUN apk add --no-cache \
    git \
    curl \
    jq \
    bash

# Crear directorio de trabajo
WORKDIR /workspace

# Copiar todo el contenido del proyecto
COPY . .

# Dar permisos de ejecución al script
RUN chmod +x scripts/deploy.sh

# Comando por defecto
ENTRYPOINT ["scripts/deploy.sh"]
