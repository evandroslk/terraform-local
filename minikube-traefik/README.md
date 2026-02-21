# Terraform - Traefik + Deploy de Teste

Este repositório contém módulos Terraform para:

1. Instalar **Traefik** via Helm no Kubernetes.  
2. Executar um **deploy de teste** que depende do Traefik.

> **Importante:** siga a ordem de execução abaixo.

---

## Passo a passo

1. Aplicar o módulo Traefik:

```bash
terraform init
terraform apply -target=module.traefik
```

2. Aplciar o módulo de teste

```bash
terraform apply -target=module.deploy-teste
```