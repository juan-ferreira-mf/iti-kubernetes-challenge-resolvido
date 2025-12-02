resource "helm_release" "kube_prometheus_stack" {
  name       = var.release_name
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.chart_version
  create_namespace = false

  atomic           = false
  skip_crds        = false
  wait             = true
  timeout          = var.timeout

  values = var.values

  depends_on = [var.namespace_resource]
}

