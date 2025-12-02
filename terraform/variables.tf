
variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig file"
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  type        = string
  description = "Kubernetes context to use"
  default     = "kind-itau-cluster"
}

variable "environment" {
  type        = string
  description = "Environment name (development, staging, production)"
  default     = "development"
}

variable "helm_timeout" {
  type        = number
  description = "Timeout for Helm operations in seconds"
  default     = 600
}


variable "enable_rest_api" {
  type        = bool
  description = "Enable REST API deployment"
  default     = true
}


variable "rest_api_release_name" {
  type        = string
  description = "Name of the REST API Helm release"
  default     = "iti-kubernetes-challenge"
}

variable "rest_api_namespace" {
  type        = string
  description = "Namespace where REST API will be deployed"
  default     = "rest-api"
}

variable "rest_api_chart_path" {
  type        = string
  description = "Path to the REST API Helm chart directory"
  default     = "../kubernetes"
}

variable "rest_api_replica_count" {
  type        = number
  description = "Number of REST API replicas"
  default     = 2
}

variable "rest_api_image_repository" {
  type        = string
  description = "Docker image repository for REST API"
  default     = "juanferreiramf/iti-kubernetes-challenge"
}

variable "rest_api_image_tag" {
  type        = string
  description = "Docker image tag for REST API"
  default     = "latest"
}

variable "rest_api_image_pull_policy" {
  type        = string
  description = "Image pull policy for REST API"
  default     = "IfNotPresent"
}

variable "rest_api_service_type" {
  type        = string
  description = "Kubernetes service type for REST API"
  default     = "ClusterIP"
}

variable "rest_api_service_port" {
  type        = number
  description = "Service port for REST API"
  default     = 80
}

variable "rest_api_service_target_port" {
  type        = number
  description = "Service target port for REST API"
  default     = 8080
}

variable "rest_api_env_target" {
  type        = string
  description = "TARGET environment variable for REST API"
  default     = "World"
}

variable "rest_api_env_port" {
  type        = string
  description = "PORT environment variable for REST API"
  default     = "8080"
}

variable "rest_api_resources_requests_cpu" {
  type        = string
  description = "CPU request for REST API"
  default     = "100m"
}

variable "rest_api_resources_requests_memory" {
  type        = string
  description = "Memory request for REST API"
  default     = "128Mi"
}

variable "rest_api_resources_limits_cpu" {
  type        = string
  description = "CPU limit for REST API"
  default     = "500m"
}

variable "rest_api_resources_limits_memory" {
  type        = string
  description = "Memory limit for REST API"
  default     = "512Mi"
}

variable "rest_api_autoscaling_enabled" {
  type        = bool
  description = "Enable Horizontal Pod Autoscaler for REST API"
  default     = true
}

variable "rest_api_autoscaling_min_replicas" {
  type        = number
  description = "Minimum number of replicas for REST API HPA"
  default     = 2
}

variable "rest_api_autoscaling_max_replicas" {
  type        = number
  description = "Maximum number of replicas for REST API HPA"
  default     = 10
}

variable "rest_api_autoscaling_target_cpu" {
  type        = number
  description = "Target CPU utilization percentage for REST API HPA"
  default     = 80
}

variable "rest_api_autoscaling_target_memory" {
  type        = number
  description = "Target memory utilization percentage for REST API HPA"
  default     = 80
}

variable "rest_api_pdb_enabled" {
  type        = bool
  description = "Enable Pod Disruption Budget for REST API"
  default     = true
}

variable "rest_api_pdb_min_available" {
  type        = number
  description = "Minimum available pods for REST API PDB"
  default     = 1
}

variable "enable_kube_prometheus_stack" {
  type        = bool
  description = "Enable kube-prometheus-stack deployment"
  default     = false
}

variable "kube_prometheus_release_name" {
  type        = string
  description = "Name of the kube-prometheus-stack Helm release"
  default     = "kube-prometheus"
}

variable "kube_prometheus_namespace" {
  type        = string
  description = "Namespace where kube-prometheus-stack will be deployed"
  default     = "monitoring"
}

variable "kube_prometheus_chart_version" {
  type        = string
  description = "Version of the kube-prometheus-stack chart"
  default     = "69.3.1"
}

variable "grafana_admin_password" {
  type        = string
  description = "Grafana admin password"
  default     = "admin"
  sensitive   = true
}

variable "enable_loki" {
  type        = bool
  description = "Enable Loki deployment"
  default     = false
}

variable "loki_release_name" {
  type        = string
  description = "Name of the Loki Helm release"
  default     = "loki"
}

variable "loki_chart_version" {
  type        = string
  description = "Version of the loki-stack chart"
  default     = "2.9.10"
}

variable "enable_tempo" {
  type        = bool
  description = "Enable Tempo deployment"
  default     = false
}

variable "tempo_release_name" {
  type        = string
  description = "Name of the Tempo Helm release"
  default     = "tempo"
}

variable "tempo_chart_version" {
  type        = string
  description = "Version of the tempo chart"
  default     = "1.8.0"
}

variable "enable_metrics_server" {
  type        = bool
  description = "Enable metrics-server deployment"
  default     = false
}

variable "metrics_server_release_name" {
  type        = string
  description = "Name of the metrics-server Helm release"
  default     = "metrics-server"
}

variable "metrics_server_namespace" {
  type        = string
  description = "Namespace where metrics-server will be deployed"
  default     = "kube-system"
}

variable "metrics_server_chart_version" {
  type        = string
  description = "Version of the metrics-server chart"
  default     = "3.12.0"
}
