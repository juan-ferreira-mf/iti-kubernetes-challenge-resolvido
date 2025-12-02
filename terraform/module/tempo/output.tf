output "release_name" {
  description = "Name of the Helm release"
  value       = helm_release.tempo.name
}

output "release_namespace" {
  description = "Namespace where the release is deployed"
  value       = helm_release.tempo.namespace
}

output "release_version" {
  description = "Version of the Helm release"
  value       = helm_release.tempo.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.tempo.status
}

output "release_id" {
  description = "ID of the Helm release"
  value       = helm_release.tempo.id
}

