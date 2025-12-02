output "release_name" {
  description = "Name of the Helm release"
  value       = helm_release.app.name
}

output "release_namespace" {
  description = "Namespace where the release is deployed"
  value       = helm_release.app.namespace
}

output "release_version" {
  description = "Version of the Helm release"
  value       = helm_release.app.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.app.status
}

output "release_id" {
  description = "ID of the Helm release"
  value       = helm_release.app.id
}

