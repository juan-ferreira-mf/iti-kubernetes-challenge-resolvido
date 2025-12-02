locals {
  rest_api_values = [
    <<EOF
replicaCount: ${var.rest_api_replica_count}
namespace: ${var.rest_api_namespace}

image:
  repository: ${var.rest_api_image_repository}
  tag: ${var.rest_api_image_tag}
  pullPolicy: ${var.rest_api_image_pull_policy}

service:
  type: ${var.rest_api_service_type}
  port: ${var.rest_api_service_port}
  targetPort: ${var.rest_api_service_target_port}

env:
  TARGET: "${var.rest_api_env_target}"
  PORT: "${var.rest_api_env_port}"

resources:
  requests:
    cpu: ${var.rest_api_resources_requests_cpu}
    memory: ${var.rest_api_resources_requests_memory}
  limits:
    cpu: ${var.rest_api_resources_limits_cpu}
    memory: ${var.rest_api_resources_limits_memory}

autoscaling:
  enabled: ${var.rest_api_autoscaling_enabled}
  minReplicas: ${var.rest_api_autoscaling_min_replicas}
  maxReplicas: ${var.rest_api_autoscaling_max_replicas}
  targetCPUUtilizationPercentage: ${var.rest_api_autoscaling_target_cpu}
  targetMemoryUtilizationPercentage: ${var.rest_api_autoscaling_target_memory}

podDisruptionBudget:
  enabled: ${var.rest_api_pdb_enabled}
  minAvailable: ${var.rest_api_pdb_min_available}
EOF
  ]

  kube_prometheus_stack_values = [
    <<EOF
crds:
  enabled: true
  upgradeJob:
    enabled: true

prometheus:
  enabled: true
  prometheusSpec:
    retention: 15d
    retentionSize: 50GiB
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: standard
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: 50Gi
    resources:
      requests:
        cpu: 500m
        memory: 2Gi
      limits:
        cpu: 2000m
        memory: 4Gi

grafana:
  enabled: true
  adminPassword: ${var.grafana_admin_password}
  persistence:
    enabled: true
    storageClassName: standard
    size: 10Gi
  service:
    type: ClusterIP
    port: 80
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 500m
      memory: 512Mi
  sidecar:
    dashboards:
      enabled: true
      label: grafana_dashboard
      labelValue: "1"
  additionalDataSources:
    - name: Loki
      type: loki
      url: http://loki:3100
      access: proxy
      isDefault: false
    - name: Tempo
      type: tempo
      url: http://tempo:3200
      access: proxy
      isDefault: false

alertmanager:
  enabled: true
  alertmanagerSpec:
    storage:
      volumeClaimTemplate:
        spec:
          storageClassName: standard
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: 10Gi
  config:
    global:
      resolve_timeout: 5m
EOF
  ]

  loki_values = [
    <<EOF
promtail:
  enabled: true
  config:
    clients:
      - url: http://loki:3100/loki/api/v1/push
    scrape_configs:
      - job_name: kubernetes-pods
        kubernetes_sd_configs:
          - role: pod
        relabel_configs:
          - source_labels: [__meta_kubernetes_pod_node_name]
            target_label: __host__
          - action: labelmap
            regex: __meta_kubernetes_pod_label_(.+)
          - action: replace
            source_labels: [__meta_kubernetes_namespace]
            target_label: namespace
          - action: replace
            source_labels: [__meta_kubernetes_pod_name]
            target_label: pod
          - action: replace
            source_labels: [__meta_kubernetes_pod_container_name]
            target_label: container
        pipeline_stages:
          - cri: {}

grafana:
  enabled: false

datasources:
  enabled: false

loki:
  enabled: true
  persistence:
    enabled: true
    storageClass: standard
    size: 50Gi
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 2000m
      memory: 4Gi
  config:
    limits_config:
      ingestion_rate_mb: 10
      ingestion_burst_size_mb: 20
      max_streams_per_user: 10000
      max_line_size: 256000

service:
  type: ClusterIP
  port: 3100
EOF
  ]

  tempo_values = [
    <<EOF
tempo:
  enabled: true
  persistence:
    enabled: true
    storageClass: standard
    size: 20Gi
  resources:
    requests:
      cpu: 500m
      memory: 1Gi
    limits:
      cpu: 1000m
      memory: 2Gi
  config:
    server:
      http_listen_port: 3200
      grpc_listen_port: 9095
    distributor:
      receivers:
        jaeger:
          protocols:
            grpc:
            thrift_http:
            thrift_binary:
            thrift_compact:
        zipkin:
        otlp:
          protocols:
            grpc:
            http:
        opencensus:
    ingester:
      max_block_duration: 5m
    querier:
      frontend_worker:
        frontend_address: tempo-query-frontend:9095
    query_frontend:
      search:
        duration_slo: 5s
    compactor:
      compaction:
        block_retention: 1h
    storage:
      trace:
        backend: local
        local:
          path: /var/tempo/traces

service:
  type: ClusterIP
  port: 3200
  name: tempo
EOF
  ]

  metrics_server_values = [
    <<EOF
args:
  - --kubelet-insecure-tls
EOF
  ]
}

