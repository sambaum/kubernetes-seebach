#!/bin/bash
parent_path=$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd -P
)

cd "$parent_path"

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack -f kube-prometheus-stack-values.yaml
# helm upgrade --install loki-stack grafana/loki-stack --set loki.persistence.enabled=true,loki.persistence.storageClassName=openebs-local-hostpath-data,loki.persistence.size=1Gi
helm upgrade --install loki-stack grafana/loki-stack -f loki-stack-values.yaml

# helm upgrade --install loki grafana/loki-stack \
# 	--set loki.persistence.enabled=true,loki.persistence.storageClassName=openebs-local-hostpath-data,loki.persistence.size=1Gi,"promtail.extraScrapeConfigs=- job_name: syslog
#       syslog:
#         listen_address: 0.0.0.0:1514
#         labels:
#           job: \"syslog\"
#     relabel_configs:
#       - source_labels: ['__syslog_message_hostname']
#         target_label: 'host'",syslogService.enabled=true,syslogService.type=LoadBalancer,syslogService.port=1514
