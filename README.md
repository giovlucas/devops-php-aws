# Teste Técnico – Analista DevOps

## Visão Geral

Este repositório apresenta uma proposta de modernização do processo de deploy de uma aplicação PHP legada utilizando práticas modernas de DevOps.

A solução implementa:

* Containerização da aplicação com Docker
* Pipeline de Integração Contínua (CI) utilizando GitHub Actions
* Publicação da imagem em um registro público (Docker Hub)
* Provisionamento de infraestrutura na AWS utilizando Terraform
* Orquestração de containers com Kubernetes (Amazon EKS)

O objetivo é criar um fluxo de entrega mais confiável, automatizado e escalável.

---

# Arquitetura da Solução

Fluxo geral da solução:

```
Desenvolvedor realiza push no repositório
            ↓
GitHub Actions executa pipeline de CI
            ↓
Build da imagem Docker
            ↓
Análise de vulnerabilidades da imagem
            ↓
Push da imagem para o Docker Hub
            ↓
Infraestrutura provisionada com Terraform
            ↓
Aplicação implantada no cluster Kubernetes (EKS)
```

Componentes utilizados:

* Docker para containerização
* GitHub Actions para CI
* Docker Hub como container registry
* Terraform para infraestrutura como código
* Amazon EKS para orquestração Kubernetes

Referências:

* Docker: https://docs.docker.com
* GitHub Actions: https://docs.github.com/actions
* Terraform: https://developer.hashicorp.com/terraform/docs
* Amazon EKS: https://docs.aws.amazon.com/eks/

---

# Etapa 1 – Containerização da Aplicação

A aplicação PHP foi containerizada utilizando Docker.

Principais decisões técnicas:

* Utilização de uma imagem oficial do PHP
* Configuração do container para expor a aplicação na porta 80
* Construção de uma imagem leve e reproduzível

Benefícios:

* Padronização do ambiente de execução
* Eliminação do problema "funciona na minha máquina"
* Facilidade de deploy em diferentes ambientes

Referência:

* https://hub.docker.com/_/php

---

# Etapa 2 – Pipeline de Integração Contínua (CI)

Foi criado um pipeline de CI utilizando GitHub Actions que é executado automaticamente a cada push na branch principal.

Etapas do pipeline:

1. Checkout do código do repositório
2. Build da imagem Docker
3. Análise de vulnerabilidades da imagem
4. Publicação da imagem no Docker Hub

Essa automação garante que toda alteração no código gere uma nova imagem validada e pronta para deploy.

Referências:

* GitHub Actions: https://docs.github.com/actions
* Docker Build: https://docs.docker.com/engine/reference/commandline/build/
* Docker Hub: https://docs.docker.com/docker-hub/

---

# Etapa 3 – Infraestrutura como Código (IaC)

A infraestrutura foi definida utilizando Terraform.

O Terraform provisiona os seguintes recursos na AWS:

* VPC para isolamento da rede
* Subnets públicas e privadas
* Cluster Kubernetes utilizando Amazon EKS
* Node Group para execução dos workloads

A utilização de infraestrutura como código permite:

* Versionamento da infraestrutura
* Reprodutibilidade entre ambientes
* Automação do provisionamento

Referências:

* Terraform AWS Provider
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs

* Terraform EKS Module
  https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

---

# Deploy da Aplicação no Kubernetes

Após a criação do cluster EKS, a aplicação é implantada utilizando manifestos Kubernetes.

Os arquivos incluídos no repositório são:

* deployment.yaml – define os pods da aplicação
* service.yaml – expõe a aplicação através de um LoadBalancer

O Deployment gerencia a execução e escalabilidade da aplicação, enquanto o Service permite o acesso externo.

Referências:

* Kubernetes Deployments
  https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

* Kubernetes Services
  https://kubernetes.io/docs/concepts/services-networking/service/

---

# Estratégia de Continuous Deployment (CD)

O pipeline atual implementa CI. Para evoluí-lo para CD, os seguintes passos poderiam ser adicionados:

1. Autenticação no cluster EKS durante o pipeline
2. Atualização da imagem utilizada no Deployment
3. Execução de `kubectl apply` para atualizar a aplicação

Fluxo proposto:

```
Push no repositório
        ↓
CI executa build e testes
        ↓
Nova imagem publicada no Docker Hub
        ↓
Pipeline autentica no EKS
        ↓
Kubernetes atualiza o Deployment
```

Referências:

* kubectl: https://kubernetes.io/docs/reference/kubectl/

---

# Estratégia de Observabilidade

Para monitorar a aplicação em produção, seria adotada uma stack baseada em ferramentas amplamente utilizadas no ecossistema Kubernetes.

Stack proposta:

Monitoramento de métricas:

* Prometheus

Visualização:

* Grafana

Coleta e análise de logs:

* Elasticsearch
* Fluentd
* Kibana

Referências:

* Prometheus: https://prometheus.io/docs/introduction/overview/
* Grafana: https://grafana.com/docs/
* Kubernetes Monitoring: https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/

---

# Métricas Principais Monitoradas

Três métricas fundamentais para acompanhar a saúde do sistema:

1. Utilização de CPU e memória dos pods
   Permite identificar gargalos de recursos.

2. Taxa de erros da aplicação (HTTP 5xx)
   Indica falhas ou instabilidade no serviço.

3. Tempo de resposta da aplicação (latência)
   Ajuda a identificar degradação de performance.

Essas métricas permitem detectar rapidamente problemas de infraestrutura ou da própria aplicação.

---

# Conclusão

A solução proposta aplica práticas modernas de DevOps para modernizar o processo de entrega da aplicação.

Com a utilização de containerização, CI/CD e infraestrutura como código, o ambiente se torna mais previsível, escalável e seguro, permitindo entregas mais rápidas e confiáveis.
