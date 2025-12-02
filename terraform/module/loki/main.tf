resource "helm_release" "loki" {
  name       = var.release_name
  namespace  = var.namespace
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = var.chart_version
  create_namespace = false

  atomic           = false
  skip_crds        = false
  wait             = true
  timeout          = var.timeout

  values = var.values

  depends_on = [var.namespace_resource]
}

