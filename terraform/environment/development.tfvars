
kubeconfig_path    = "~/.kube/config"
kubeconfig_context = "kind-itau-cluster"
environment       = "development"

enable_rest_api = true


rest_api_release_name = "iti-kubernetes-challenge"
rest_api_namespace    = "rest-api"
rest_api_chart_path   = "../kubernetes"

rest_api_replica_count = 2

rest_api_image_repository = "juanferreiramf/iti-kubernetes-challenge"
rest_api_image_tag        = "latest"
rest_api_image_pull_policy = "IfNotPresent"

rest_api_service_type       = "ClusterIP"
rest_api_service_port       = 80
rest_api_service_target_port = 8080

rest_api_env_target = "World"
rest_api_env_port   = "8080"

rest_api_resources_requests_cpu    = "100m"
rest_api_resources_requests_memory = "128Mi"
rest_api_resources_limits_cpu     = "500m"
rest_api_resources_limits_memory   = "512Mi"

rest_api_autoscaling_enabled              = true
rest_api_autoscaling_min_replicas         = 2
rest_api_autoscaling_max_replicas         = 10
rest_api_autoscaling_target_cpu           = 80
rest_api_autoscaling_target_memory         = 80

rest_api_pdb_enabled      = true
rest_api_pdb_min_available = 1

enable_kube_prometheus_stack = true

kube_prometheus_release_name = "kube-prometheus"
kube_prometheus_namespace    = "monitoring"
kube_prometheus_chart_version = "69.3.1"

grafana_admin_password = "admin"

enable_loki = true

loki_release_name = "loki"
loki_chart_version = "2.9.10"

enable_tempo = true

tempo_release_name = "tempo"
tempo_chart_version = "1.8.0"

enable_metrics_server = true

metrics_server_release_name = "metrics-server"
metrics_server_namespace    = "kube-system"
metrics_server_chart_version = "3.12.0"
