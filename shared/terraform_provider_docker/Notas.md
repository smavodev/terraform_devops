
#### Inicializa el proyecto
terraform init

#### Muestra qué se va a aplicar
terraform plan

#### Aplica los recursos
```shell
terraform apply -auto-approve

#### Verifica contenedores
```shell
docker ps
```

#### Ver logs
```shell
docker logs roxs-postgres
docker logs roxs-redis
docker logs roxs-nginx
```

#### Ver los outputs
```shell
terraform output
```

#### Destruir toda la infraestructura
```shell
terraform destroy -auto-approve
```

#### Verifica si PostgreSQL está corriendo
```shell
docker exec -it roxs-postgres psql -U postgres -d voting_app

```
#### Verifica si Redis responde
```shell
docker exec roxs-redis redis-cli ping
```

#### Verifica conectividad entre contenedores
```shell
docker exec roxs-nginx ping postgres
docker exec roxs-nginx ping redis
```

## Link Codigo base de ejemplo:
[Ejemplo Base](https://www.notion.so/smavodev/Gu-a-Terraform-Docker-Entorno-con-PostgreSQL-Redis-y-NGINX-231a73a196f880b2be83d421a292050b)

--- 
Ejecucion 1:
Para usar los valores de environment.tfvars:
```shell
terraform apply -var-file="environment.tfvars"

```

Ejecucion 2:
Si quieres que se cargue automáticamente sin especificarlo cada vez:
Renombarlo de **environment.tfvars** a **terraform.auto.tfvars**

```shell
terraform apply
```
---

Dev:
```shell
terraform apply -var-file="dev.tfvars"
```

Staging:
```shell
terraform apply -var-file="staging.tfvars"
```

Prod:
```shell
terraform apply -var-file="prod.tfvars"
```