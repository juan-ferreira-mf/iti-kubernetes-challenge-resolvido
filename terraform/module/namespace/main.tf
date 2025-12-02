resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.name
    labels = merge(
      {
        app = var.app_name
      },
      var.labels
    )
  }
}

