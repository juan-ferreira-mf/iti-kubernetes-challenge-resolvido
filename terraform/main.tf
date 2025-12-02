
module "rest_api_namespace" {
  source = "./module/namespace"
  count  = var.enable_rest_api ? 1 : 0

  name     = var.rest_api_namespace
  app_name = "rest-api"
  labels = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

module "rest_api" {
  source = "./module/helm_app"
  count  = var.enable_rest_api ? 1 : 0

  app_name         = var.rest_api_release_name
  namespace        = var.rest_api_namespace
  chart_path       = var.rest_api_chart_path
  values           = local.rest_api_values
  timeout          = var.helm_timeout
  namespace_resource = module.rest_api_namespace[0]
}

module "monitoring_namespace" {
  source = "./module/namespace"
  count  = var.enable_kube_prometheus_stack ? 1 : 0

  name     = var.kube_prometheus_namespace
  app_name = "monitoring"
  labels = {
    environment = var.environment
    managed-by  = "terraform"
  }
}

module "kube_prometheus_stack" {
  source = "./module/kube_prometheus_stack"
  count  = var.enable_kube_prometheus_stack ? 1 : 0

  release_name      = var.kube_prometheus_release_name
  namespace         = var.kube_prometheus_namespace
  chart_version     = var.kube_prometheus_chart_version
  values            = local.kube_prometheus_stack_values
  timeout           = var.helm_timeout
  namespace_resource = module.monitoring_namespace[0]
}

module "loki" {
  source = "./module/loki"
  count  = var.enable_loki ? 1 : 0

  release_name      = var.loki_release_name
  namespace         = var.kube_prometheus_namespace
  chart_version     = var.loki_chart_version
  values            = local.loki_values
  timeout           = var.helm_timeout
  namespace_resource = module.monitoring_namespace[0]
}

module "tempo" {
  source = "./module/tempo"
  count  = var.enable_tempo ? 1 : 0

  release_name      = var.tempo_release_name
  namespace         = var.kube_prometheus_namespace
  chart_version     = var.tempo_chart_version
  values            = local.tempo_values
  timeout           = var.helm_timeout
  namespace_resource = module.monitoring_namespace[0]
}

data "kubernetes_namespace" "kube_system" {
  count = var.enable_metrics_server ? 1 : 0
  metadata {
    name = var.metrics_server_namespace
  }
}

module "metrics_server" {
  source = "./module/metrics_server"
  count  = var.enable_metrics_server ? 1 : 0

  release_name      = var.metrics_server_release_name
  namespace         = var.metrics_server_namespace
  chart_version     = var.metrics_server_chart_version
  values            = local.metrics_server_values
  timeout           = var.helm_timeout
  namespace_resource = data.kubernetes_namespace.kube_system[0]
}

resource "kubernetes_config_map" "grafana_dashboard" {
  count = var.enable_kube_prometheus_stack ? 1 : 0

  metadata {
    name      = "grafana-dashboard-15661"
    namespace = var.kube_prometheus_namespace
    labels = {
      grafana_dashboard = "1"
    }
    annotations = {
      grafana_folder = "kubernetes"
    }
  }

  data = {
    "15661_rev2.json" = fileexists("${path.module}/dashboards/kubernetes/15661_rev2.json") ? file("${path.module}/dashboards/kubernetes/15661_rev2.json") : "{}"
  }

  depends_on = [
    module.monitoring_namespace,
    module.kube_prometheus_stack
  ]
}

