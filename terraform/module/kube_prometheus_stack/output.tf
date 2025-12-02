output "release_name" {
  description = "Name of the Helm release"
  value       = helm_release.kube_prometheus_stack.name
}

output "release_namespace" {
  description = "Namespace where the release is deployed"
  value       = helm_release.kube_prometheus_stack.namespace
}

output "release_version" {
  description = "Version of the Helm release"
  value       = helm_release.kube_prometheus_stack.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.kube_prometheus_stack.status
}

output "release_id" {
  description = "ID of the Helm release"
  value       = helm_release.kube_prometheus_stack.id
}

