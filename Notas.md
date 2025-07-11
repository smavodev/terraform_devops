
### Instalaciones 

#### Terraform
Link: https://developer.hashicorp.com/terraform/install

#### Instalacion terraform en linux
```shell
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### 📁 Anatomía de un Proyecto Terraform
🏗️ Estructura Básica
```markdown
mi-proyecto-terraform/
├── main.tf                 # 🏠 Configuración principal
├── variables.tf            # 📝 Definición de variables de entrada
├── outputs.tf              # 📤 Valores de salida
├── locals.tf               # 🧮 Variables calculadas localmente
├── versions.tf             # 📌 Versiones de Terraform y providers
├── terraform.tfvars        # 🔧 Valores de variables (no versionar si hay secrets)
├── terraform.tfvars.example # 📋 Ejemplo de variables
├── .terraform.lock.hcl     # 🔒 Lock file de dependencias
├── .gitignore              # 🚫 Archivos a ignorar
├── README.md               # 📚 Documentación del proyecto
├── .terraform/             # 📦 Archivos internos (NO versionar)
├── *.tfstate*              # 💾 Archivos de estado (NO versionar)
└── modules/                # 📦 Módulos reutilizables
├── networking/
├── compute/
└── storage/
```

🏢 Estructura Avanzada (Empresa)
```markdown
terraform-infrastructure/
├── environments/           # 🌍 Configuraciones por ambiente
│   ├── dev/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   └── prod/
├── modules/                # 📦 Módulos personalizados
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   └── iam/
├── shared/                 # 🤝 Recursos compartidos
│   ├── data-sources.tf
│   ├── providers.tf
│   └── remote-state.tf
├── scripts/                # 🔧 Scripts de automatización
│   ├── deploy.sh
│   ├── destroy.sh
│   └── validate.sh
├── docs/                   # 📚 Documentación
├── tests/                  # 🧪 Tests de infraestructura
└── .github/workflows/      # 🚀 CI/CD pipelines
```

### Comandos Básicos
Inicializar el proyecto:
```shell
sudo cp -r /home/vagrant/shared/terraform-dia22-devops /home/smavodev/

cd terraform-dia22-devops

# Dar permisos en la carpeta 
sudo chown -R $USER:$USER .
```
```shell
# 1. Inicializar Terraform
terraform init

# 2. Validar configuración
terraform validate

# 3. Formatear código
terraform fmt

# 4. Ver plan de ejecución
terraform plan

# 5. Aplicar configuración
terraform apply

# 6. Explorar archivos generados
ls -la
cat README.md
cat outputs/project-config.json | jq .
cat outputs/progress-report.txt

# 7. Ver outputs
terraform output

# 8. Ver output específico
terraform output learning_stats
```

```shell
# Cambiar variables y re-aplicar
terraform apply -var="student_name=TuNuevoNombre"

# Deshabilitar algunos archivos
terraform apply -var='generate_files={"readme"=true,"config"=false,"progress"=true,"roadmap"=false}'

# Ver el estado actual
terraform show

# Destruir cuando termines
terraform destroy
```

#### Busquedas en los logs 
```shell
# Ver los ultimos 20 lineas
tail -n 20 terraform.log 

# Buscar mensajes en especifico
grep "ERROR" terraform.log
grep "INFO" terraform.log

# Mosrar los ultimos errores
grep "ERROR" terraform.log | tail -n 10
grep -E "INFO|WARN" terraform.log | tail -n 20

# Ver logs en tiempo real
tail -f terraform.log | grep --line-buffered "ERROR"
```