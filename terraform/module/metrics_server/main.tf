resource "helm_release" "metrics_server" {
  name       = var.release_name
  namespace  = var.namespace
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = var.chart_version
  create_namespace = false

  atomic           = false
  skip_crds        = false
  wait             = true
  timeout          = var.timeout

  values = var.values

  depends_on = [var.namespace_resource]
}

