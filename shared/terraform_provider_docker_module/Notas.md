
# Terraform Module

```markdown
terraform_provider_docker_module/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── enviroments
│   ├── dev.tfvars
│   ├── staging.tfvars
│   ├── prod.tfvars
├── nginx.conf
├── .gitignore
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── volumes/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── postgres/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── redis/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   └── nginx/
│       ├── main.tf
│       ├── outputs.tf
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

```shell
terraform output 
terraform output all_info
```