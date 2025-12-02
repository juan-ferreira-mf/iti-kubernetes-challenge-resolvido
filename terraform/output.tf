
output "rest_api_release_name" {
  description = "Name of the REST API Helm release"
  value       = var.enable_rest_api ? module.rest_api[0].release_name : null
}

output "rest_api_release_namespace" {
  description = "Namespace where REST API is deployed"
  value       = var.enable_rest_api ? module.rest_api[0].release_namespace : null
}

output "rest_api_release_version" {
  description = "Version of the REST API Helm release"
  value       = var.enable_rest_api ? module.rest_api[0].release_version : null
}

output "rest_api_release_status" {
  description = "Status of the REST API Helm release"
  value       = var.enable_rest_api ? module.rest_api[0].release_status : null
}

output "rest_api_deployment_name" {
  description = "Name of the REST API Kubernetes deployment"
  value       = var.enable_rest_api ? "${var.rest_api_release_name}-${module.rest_api[0].release_name}" : null
}

output "rest_api_service_name" {
  description = "Name of the REST API Kubernetes service"
  value       = var.enable_rest_api ? "${var.rest_api_release_name}-${module.rest_api[0].release_name}" : null
}

output "kube_prometheus_release_name" {
  description = "Name of the kube-prometheus-stack Helm release"
  value       = var.enable_kube_prometheus_stack ? module.kube_prometheus_stack[0].release_name : null
}

output "kube_prometheus_release_namespace" {
  description = "Namespace where kube-prometheus-stack is deployed"
  value       = var.enable_kube_prometheus_stack ? module.kube_prometheus_stack[0].release_namespace : null
}

output "kube_prometheus_release_status" {
  description = "Status of the kube-prometheus-stack Helm release"
  value       = var.enable_kube_prometheus_stack ? module.kube_prometheus_stack[0].release_status : null
}

output "loki_release_name" {
  description = "Name of the Loki Helm release"
  value       = var.enable_loki ? module.loki[0].release_name : null
}

output "loki_release_status" {
  description = "Status of the Loki Helm release"
  value       = var.enable_loki ? module.loki[0].release_status : null
}

output "tempo_release_name" {
  description = "Name of the Tempo Helm release"
  value       = var.enable_tempo ? module.tempo[0].release_name : null
}

output "tempo_release_status" {
  description = "Status of the Tempo Helm release"
  value       = var.enable_tempo ? module.tempo[0].release_status : null
}

output "metrics_server_release_name" {
  description = "Name of the metrics-server Helm release"
  value       = var.enable_metrics_server ? module.metrics_server[0].release_name : null
}

output "metrics_server_release_status" {
  description = "Status of the metrics-server Helm release"
  value       = var.enable_metrics_server ? module.metrics_server[0].release_status : null
}
