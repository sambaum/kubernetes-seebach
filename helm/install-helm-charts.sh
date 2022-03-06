#!/bin/bash
parent_path=$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd -P
)

cd "$parent_path"

helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --values kube-prometheus-stack-values.yaml
helm upgrade --install loki grafana/loki-stack --set loki.persistence.enabled=true,loki.persistence.storageClassName=openebs-local-hostpath-data,loki.persistence.size=1Gi
