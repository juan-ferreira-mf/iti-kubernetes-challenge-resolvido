output "name" {
  description = "Name of the namespace"
  value       = kubernetes_namespace.namespace.metadata[0].name
}

output "id" {
  description = "ID of the namespace"
  value       = kubernetes_namespace.namespace.id
}

