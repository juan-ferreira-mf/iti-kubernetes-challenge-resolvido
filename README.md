# ITI Kubernetes Challenge

Projeto de desafio Kubernetes com deploy automatizado usando Terraform, Helm e KIND.

## Tecnologias Utilizadas

### Infraestrutura
- **KIND (Kubernetes in Docker)** - Cluster Kubernetes local
- **Terraform** - Infraestrutura como código
- **Helm** - Gerenciamento de pacotes Kubernetes
- **MetalLB** - Load Balancer para clusters KIND

### Aplicação
- **Kotlin** - Linguagem de programação
- **Ktor** - Framework web assíncrono
- **Gradle** - Sistema de build
- **Docker** - Containerização multi-plataforma (amd64/arm64)

### Observabilidade
- **kube-prometheus-stack** - Prometheus + Grafana + Alertmanager
- **Loki** - Agregação de logs
- **Tempo** - Distributed tracing
- **Metrics Server** - Métricas de recursos do cluster

### Ferramentas
- **Makefile** - Automação de tarefas
- **Helmfile** - Gerenciamento de releases Helm

## Fluxo de Deploy

### Diagrama do Fluxo

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUXO DE DEPLOY                            │
└─────────────────────────────────────────────────────────────┘

1. Criação do Cluster KIND
   │
   ├─> make cluster
   │
   └─> Cria cluster local com 1 control-plane + 2 workers
       Nome: kind-itau-cluster

2. Instalação de Dependências do Cluster
   │
   ├─> make pre
   │
   └─> Instala MetalLB para LoadBalancer services
       Namespace: metallb-system

3. Deploy de Dependências via Helm
   │
   ├─> make helm
   │
   └─> Aplica configurações via Helmfile
       (ArgoCD, Ingress Controller, etc.)

4. Build e Push da Imagem Docker
   │
   ├─> make build
   │
   └─> Build multi-plataforma (amd64/arm64)
       Push: juanferreiramf/iti-kubernetes-challenge:latest

5. Deploy da Aplicação via Terraform
   │
   ├─> cd terraform
   ├─> terraform init
   ├─> terraform plan -var-file=environment/development.tfvars
   └─> terraform apply -var-file=environment/development.tfvars
       │
       ├─> Cria namespaces (rest-api, monitoring, kube-system)
       ├─> Deploy REST API via Helm
       ├─> Deploy kube-prometheus-stack
       ├─> Deploy Loki
       ├─> Deploy Tempo
       └─> Deploy Metrics Server

6. Testes
   │
   └─> make tests
       │
       ├─> Port-forward REST API (localhost:8080)
       └─> Port-forward Grafana (localhost:8089)
```

## Makefile

### Comandos Disponíveis

#### `make cluster`
Cria o cluster KIND com o nome `kind-itau-cluster` usando a configuração em `kind-cluster/cluster.yaml`.

```bash
make cluster
```

#### `make pre`
Instala o MetalLB no cluster para prover LoadBalancer services.

```bash
make pre
```

#### `make build`
Faz build multi-plataforma (linux/amd64, linux/arm64) e push da imagem Docker para o registry.

```bash
make build
```

#### `make helm`
Aplica configurações via Helmfile.

```bash
make helm
```

#### `make tests`
Inicia port-forwards para REST API e Grafana para testes locais.

```bash
make tests
```

**URLs disponíveis:**
- REST API: http://localhost:8080
- Grafana: http://localhost:8089

**Para parar:** Pressione `Ctrl+C`

#### `make pre-destroy`
Remove o MetalLB do cluster.

```bash
make pre-destroy
```

## Testando as Aplicações

### Via Port-Forward

Execute o comando:

```bash
make tests
```

Isso iniciará os port-forwards em background:
- **REST API**: `kubectl port-forward svc/iti-kubernetes-challenge 8080:80 -n rest-api`
- **Grafana**: `kubectl port-forward svc/kube-prometheus-grafana 8089:80 -n monitoring`

### Acessando os Serviços

- **REST API**: http://localhost:8080
- **Grafana**: http://localhost:8089
  - Usuário: `admin`
  - Senha: `admin` (configurável em `terraform/environment/development.tfvars`)

### Testando a REST API

```bash
curl http://localhost:8080
# Resposta esperada: Hello World!
```

## Deploy Completo

### Passo a Passo

1. **Criar o cluster KIND**
   ```bash
   make cluster
   ```

2. **Instalar dependências do cluster (MetalLB)**
   ```bash
   make pre
   ```

3. **Deploy de dependências via Helm**
   ```bash
   make helm
   ```

4. **Build e push da imagem Docker**
   ```bash
   make build
   ```

5. **Deploy da aplicação via Terraform**
   ```bash
   cd terraform
   terraform init
   terraform plan -var-file=environment/development.tfvars
   terraform apply -var-file=environment/development.tfvars
   ```

### Verificando o Deploy

```bash
# Verificar pods da aplicação
kubectl get pods -n rest-api

# Verificar serviços
kubectl get svc -n rest-api

# Verificar recursos do monitoring
kubectl get pods -n monitoring

# Verificar releases Helm
helm list -A
```

## Estrutura do Projeto

```
.
├── app/                          # Código fonte da aplicação Kotlin
├── kubernetes/                   # Helm chart da aplicação
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
├── terraform/                    # Infraestrutura como código
│   ├── module/                  # Módulos Terraform
│   ├── environment/             # Variáveis por ambiente
│   └── dashboards/              # Dashboards Grafana
├── kind-cluster/                 # Configuração do cluster KIND
├── cluster-dependencies/         # Valores para dependências do cluster
├── Dockerfile                    # Build da imagem Docker
├── makefile                      # Automação de tarefas
└── README.md                     # Este arquivo
```

## Configuração

### Variáveis Principais

As configurações principais estão em `terraform/environment/development.tfvars`:

- `kubeconfig_context`: `kind-itau-cluster`
- `rest_api_namespace`: `rest-api`
- `kube_prometheus_namespace`: `monitoring`
- `grafana_admin_password`: Senha do Grafana

### Namespaces

- `rest-api`: Aplicação principal
- `monitoring`: Stack de observabilidade (Prometheus, Grafana, Loki, Tempo)
- `kube-system`: Metrics Server

## Limpeza

Para remover os recursos:

```bash
# Remover MetalLB
make pre-destroy

# Destruir recursos Terraform
cd terraform
terraform destroy -var-file=environment/development.tfvars

# Remover cluster KIND
kind delete cluster --name kind-itau-cluster
```

