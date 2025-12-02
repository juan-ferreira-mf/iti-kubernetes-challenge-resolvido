resource "helm_release" "app" {
  name       = var.app_name
  namespace  = var.namespace
  chart      = var.chart_path
  create_namespace = false
  
  atomic           = false
  skip_crds        = false
  wait             = true
  timeout          = var.timeout

  values = var.values

  depends_on = [var.namespace_resource]
}

