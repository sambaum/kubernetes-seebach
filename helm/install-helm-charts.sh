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
helm upgrade --install loki-stack grafana/loki-stack -f loki-stack-values.yaml
