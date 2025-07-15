
# Terraform Module

```markdown
terraform-project/
├── main.tf                  # Código principal que llama a módulos
├── variables.tf             # Variables globales (opcional)
├── environments/
│   ├── dev.tfvars
│   └── prod.tfvars
├── modules/
│   ├── network/
│   │   └── main.tf
│   │   └── variables.tf
│   ├── postgres/
│   │   └── main.tf
│   │   └── variables.tf
│   ├── redis/
│   │   └── main.tf
│   │   └── variables.tf
│   └── nginx/
│       └── main.tf
│       └── variables.tf

```
#### Comandos terraform
```shell
terraform output application_urls

```


```shell
terraform apply --auto-approve
```
---

Dev:
```shell
terraform apply -var-file="environments/dev.tfvars"
```

Staging:
```shell
terraform apply -var-file="environments/staging.tfvars"
```

Prod:
```shell
terraform apply -var-file="environments/prod.tfvars"
```


```shell
terraform destroy --auto-approve
```