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

COPY . .

RUN chmod +x deploy.sh

# Usar el script directamente (ajustado)
ENTRYPOINT ["./deploy.sh"]